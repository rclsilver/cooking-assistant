from app.controllers import BaseController
from app.models.ingredient import Ingredient
from app.schemas.ingredient import IngredientCreate, IngredientUpdate
from sqlalchemy.orm import Session
from typing import List
from uuid import UUID


class IngredientController(BaseController):
    """
    Ingredient controller
    """

    @classmethod
    def get_ingredients(cls, db: Session) -> List[Ingredient]:
        """
        Fetch all ingredients from database
        """
        return db.query(Ingredient).all()

    @classmethod
    def get_ingredient(cls, ingredient_id: UUID, db: Session) -> Ingredient:
        """
        Fetch a specific ingredient from database
        """
        return cls._get(db, Ingredient, id=ingredient_id)

    @classmethod
    def create_ingredient(cls, payload: IngredientCreate, db: Session) -> Ingredient:
        """
        Create an ingredient
        """
        cls._raise_if_already_exists(
            db.query(Ingredient).filter_by(label=payload.label),
            'Ingredient already exists with this label',
            label=payload.label
        )

        ingredient = Ingredient()
        ingredient.label = payload.label
        ingredient.label_plural = payload.label_plural
        ingredient.image_url = payload.image_url

        db.add(ingredient)
        db.commit()

        return ingredient

    @classmethod
    def update_ingredient(cls, ingredient: Ingredient, payload: IngredientUpdate, db: Session) -> Ingredient:
        """
        Update an ingredient
        """
        cls._raise_if_already_exists(
            db.query(Ingredient).filter_by(label=payload.label).filter(Ingredient.id != ingredient.id),
            'Ingredient already exists with this label',
            label=payload.label
        )

        ingredient.label = payload.label
        ingredient.label_plural = payload.label_plural
        ingredient.image_url = payload.image_url

        db.add(ingredient)
        db.commit()

        return ingredient

    @classmethod
    def delete_ingredient(cls, ingredient: Ingredient, db: Session) -> None:
        """
        Delete a ingredient from database
        """
        if ingredient.recipes:
            raise cls.RequirementsNotSatisfiedException('This ingredient is still used by at least one recipe')

        db.delete(ingredient)
        db.commit()
