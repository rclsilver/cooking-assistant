import datetime
import re

from app.schemas import BaseModel, Empty
from app.schemas.ingredient import Ingredient
from app.schemas.unit import Unit
from app.schemas.user import User
from pydantic import validator
from typing import List, Optional
from uuid import UUID


class RecipeIngredient(BaseModel):
    """
    An ingredient in a recipe
    """
    quantity: Optional[float]
    optional: bool
    ingredient: Ingredient
    unit: Optional[Unit]


class RecipeIngredientCreate(Empty):
    """
    Ingredient in a recipe payload schema
    """
    quantity: Optional[float]
    optional: bool
    ingredient_id: UUID
    unit_id: Optional[UUID]


class RecipeIngredientUpdate(Empty):
    """
    Ingredient in a recipe payload schema
    """
    quantity: Optional[float]
    optional: bool
    unit_id: Optional[UUID]


class RecipeStep(BaseModel):
    """
    A step in a recipe
    """
    order: int
    content: str


class RecipeStepCreate(Empty):
    """
    Step in a recipe payload schema
    """
    order: Optional[int]
    content: str


class RecipeStepUpdate(RecipeStepCreate):
    """
    Step in a recipe payload schema
    """
    order: int


class RecipeBase(BaseModel):
    """
    Recipe base schema
    """
    title: Optional[str]
    image_url: Optional[str]
    url: str
    author: Optional[User]
    ingredients: List[RecipeIngredient]
    steps: List[RecipeStep]


class Recipe(RecipeBase):
    """
    Recipe full schema
    """
    pass


class RecipeImport(Empty):
    """
    Recipe import payload schema
    """
    url: str

    @validator('url')
    def url_must_be_valid(cls, value: str):
        """
        Validate url field value
        """
        if not re.match(r'^https?://.+', value):
            raise ValueError('Must be a valid URL')
        return value


class RecipeSchedule(BaseModel):
    """
    A recipe in a planning
    """
    recipe: Recipe
    author: User
    date: datetime.date
