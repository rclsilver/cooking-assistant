import logging

from app.controllers import BaseController
from app.models.recipe import Recipe
from app.parsers import get_parser
from app.schemas.recipe import RecipeImport
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
