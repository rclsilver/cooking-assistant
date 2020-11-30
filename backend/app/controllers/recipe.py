import logging

from app.controllers import BaseController
from app.models.ingredient import Ingredient
from app.models.planning import RecipeSchedule
from app.models.recipe import Recipe, RecipeIngredient, RecipeStep
from app.models.unit import Unit
from app.parsers import get_parser
from app.schemas.planning import PlanningCreate
from app.schemas.recipe import RecipeCreate, RecipeImport, RecipeIngredientCreate, RecipeIngredientUpdate, RecipeStepCreate, RecipeStepUpdate
from app.schemas.user import User
from sqlalchemy.orm import Session
from typing import List, Optional
from uuid import UUID


logger = logging.getLogger(__name__)


class RecipeController(BaseController):
    """
    Recipe controller
    """

    @classmethod
    def get_recipes(cls, db: Session) -> List[Recipe]:
        """
        Fetch all recipes from database
        """
        return db.query(Recipe).all()

    @classmethod
    def get_recipe(cls, recipe_id: UUID, db: Session) -> Recipe:
        """
        Fetch a specific recipe from database
        """
        return cls._get(db, Recipe, id=recipe_id)

    @classmethod
    def create_recipe(cls, payload: RecipeCreate, author: User, db: Session) -> Recipe:
        """
        Create a recipe
        """
        recipe = Recipe()
        recipe.title = payload.title
        recipe.image_url = payload.image_url
        recipe.author_id = str(author.id)

        db.add(recipe)
        db.commit()

        return recipe

    @classmethod
    def import_recipe(cls, payload: RecipeImport, author: User, db: Session) -> Recipe:
        """
        Import a recipe from an URL
        """
        cls._raise_if_already_exists(
            db.query(Recipe).filter_by(url=payload.url),
            '{resource_type} with this URL already exists',
            url=payload.url
        )

        recipe = Recipe()
        recipe.url = payload.url
        recipe.author_id = str(author.id)

        db.add(recipe)
        db.commit()

        return recipe

    @classmethod
    def delete_recipe(cls, recipe: Recipe, db: Session) -> None:
        """
        Delete a recipe from database
        """
        for ingredient in recipe.ingredients:
            db.delete(ingredient)

        for step in recipe.steps:
            db.delete(step)

        for schedule in recipe.schedules:
            db.delete(schedule)

        db.delete(recipe)
        db.commit()

    @classmethod
    def fetch_recipe_informations(cls, recipe: Recipe, db: Session) -> Recipe:
        """
        Update recipe informations from website
        """
        try:
            parser = get_parser(recipe.url)
            content = parser.parse()

            if not recipe.title:
                logger.info(f'Updating title for {recipe.id}')
                recipe.title = content[parser.TITLE]

            if not recipe.image_url:
                logger.info(f'Updating image URL for {recipe.id}')
                recipe.image_url = content[parser.IMAGE]

            db.commit()
        except Exception:
            logger.exception(f'Unable to fetch {recipe.id} recipe informations')

        return recipe

    @classmethod
    def add_recipe_schedule(cls, recipe: Recipe, author: User, payload: PlanningCreate, db: Session) -> RecipeSchedule:
        """
        Schedule a recipe
        """
        cls._raise_if_already_exists(
            db.query(RecipeSchedule).filter_by(recipe=recipe, date=payload.date),
            'Recipe is already scheduled for this date',
            'RECIPE_SCHEDULE_ALREADY_EXISTS',
            date=payload.date
        )

        schedule = RecipeSchedule()
        schedule.recipe_id = str(recipe.id)
        schedule.author_id = str(author.id)
        schedule.date = payload.date

        db.add(schedule)
        db.commit()

        return schedule

    @classmethod
    def remove_recipe_schedule(cls, schedule: RecipeSchedule, db: Session) -> None:
        """
        Unschedule a recipe
        """
        db.delete(schedule)
        db.commit()

    @classmethod
    def get_recipe_ingredient(cls, recipe: Recipe, ingredient_id: UUID, db: Session) -> RecipeIngredient:
        """
        Get an ingredient in a recipe
        """
        return cls._get(db, RecipeIngredient, recipe=recipe, id=ingredient_id)

    @classmethod
    def add_recipe_ingredient(cls, recipe: Recipe, payload: RecipeIngredientCreate, db: Session) -> RecipeIngredient:
        """
        Add an ingredient in a recipe
        """
        target_ingredient = cls._get_foreign(db, Ingredient, id=payload.ingredient_id)
        target_unit = cls._get_foreign(db, Unit, id=payload.unit_id) if payload.unit_id else None

        cls._raise_if_already_exists(
            db.query(RecipeIngredient).filter_by(recipe=recipe, ingredient=target_ingredient),
            'Ingredient is already present in this recipe',
            'RECIPE_INGREDIENT_ALREADY_EXISTS',
            ingredient_id=payload.ingredient_id
        )

        ingredient = RecipeIngredient()
        ingredient.quantity = payload.quantity
        ingredient.optional = payload.optional
        ingredient.recipe_id = str(recipe.id)
        ingredient.ingredient_id = str(target_ingredient.id)
        ingredient.unit_id = str(target_unit.id) if target_unit else None

        db.add(ingredient)
        db.commit()

        return ingredient

    @classmethod
    def update_recipe_ingredient(cls, recipe: Recipe, ingredient: RecipeIngredient, payload: RecipeIngredientUpdate, db: Session) -> RecipeIngredient:
        """
        Update an ingredient in a recipe
        """
        target_unit = cls._get_foreign(db, Unit, id=payload.unit_id) if payload.unit_id else None

        ingredient.quantity = payload.quantity
        ingredient.optional = payload.optional
        ingredient.unit_id = str(target_unit.id) if target_unit else None

        db.add(ingredient)
        db.commit()

        return ingredient

    @classmethod
    def delete_recipe_ingredient(cls, recipe: Recipe, ingredient: RecipeIngredient, db: Session) -> None:
        """
        Delete an ingredient from a recipe
        """
        db.delete(ingredient)
        db.commit()

    @classmethod
    def get_recipe_step(cls, recipe: Recipe, step_id: UUID, db: Session) -> RecipeStep:
        """
        Get a step in a recipe
        """
        return cls._get(db, RecipeStep, recipe=recipe, id=step_id)

    @classmethod
    def add_recipe_step(cls, recipe: Recipe, payload: RecipeStepCreate, db: Session) -> RecipeStep:
        """
        Add a step in a recipe
        """
        step = RecipeStep()
        step.content = payload.content
        step.recipe_id = str(recipe.id)

        if payload.order:
            step.order = payload.order
        else:
            for existing_step in recipe.steps:
                if not step.order or step.order <= existing_step.order:
                    step.order =  existing_step.order + 1
            if not step.order:
                step.order = 1

        # Move down all existing steps
        for existing_step in db.query(RecipeStep).filter(
            RecipeStep.recipe_id == str(recipe.id),
            RecipeStep.order >= step.order
        ).order_by(
            RecipeStep.order.desc()
        ).all():
            existing_step.order += 1
            db.add(existing_step)
            db.flush()

        db.add(step)
        db.commit()

        return step

    @classmethod
    def update_recipe_step(cls, recipe: Recipe, step: RecipeStep, payload: RecipeStepUpdate, db: Session) -> RecipeStep:
        """
        Update a step in a recipe
        """
        step.content = payload.content
        step_order = step.order

        # Define a temporary order for the step
        step.order = 0
        db.add(step)
        db.flush()

        # Organize other steps with the new order
        if step_order - payload.order > 0:
            for existing_step in db.query(RecipeStep).filter(
                RecipeStep.recipe_id == str(recipe.id),
                RecipeStep.order.between(payload.order, step_order)
            ).order_by(
                RecipeStep.order.desc()
            ).all():
                existing_step.order += 1
                db.add(existing_step)
                db.flush()
        elif payload.order - step_order > 0:
            for existing_step in db.query(RecipeStep).filter(
                RecipeStep.recipe_id == str(recipe.id),
                RecipeStep.order.between(step_order, payload.order)
            ).order_by(
                RecipeStep.order.asc()
            ).all():
                existing_step.order -= 1
                db.add(existing_step)
                db.flush()

        step.order = payload.order

        db.add(step)
        db.commit()

        return step

    @classmethod
    def delete_recipe_step(cls, recipe: Recipe, step: RecipeStep, db: Session) -> None:
        """
        Delete an ingredient from a recipe
        """
        db.delete(step)
        db.flush()

        # Move up all following steps
        for existing_step in db.query(RecipeStep).filter(
            RecipeStep.recipe_id == str(recipe.id),
            RecipeStep.order > step.order
        ).order_by(
            RecipeStep.order.asc()
        ).all():
            existing_step.order -= 1
            db.add(existing_step)
            db.flush()

        db.commit()
