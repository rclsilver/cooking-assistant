import re

from app.schemas import BaseModel, Empty
from pydantic import validator
from typing import Optional


class IngredientBase(BaseModel):
    """
    Ingredient base schema
    """
    label: str
    label_plural: Optional[str]
    image_url: Optional[str]


class Ingredient(IngredientBase):
    """
    Ingredient full schema
    """
    pass


class IngredientCreate(Empty):
    """
    Ingredient create schema
    """
    label: str
    label_plural: Optional[str]
    image_url: Optional[str]

    @validator('label')
    def label_must_be_valid(cls, value: str):
        """
        Validate label field value
        """
        if not value.strip():
            raise ValueError('Label cannot be empty')
        return value.strip()

    @validator('image_url')
    def image_url_must_be_valid(cls, value: Optional[str]):
        """
        Validate image_url field value
        """
        if value and not re.match(r'^https?://.+', value):
            raise ValueError('Must be a valid URL')
        return value


class IngredientUpdate(IngredientCreate):
    """
    Ingredient update schema
    """
    pass
