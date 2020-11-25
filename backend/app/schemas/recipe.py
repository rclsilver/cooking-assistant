import re

from app.schemas import BaseModel, Empty
from app.schemas.user import User
from pydantic import validator
from typing import Optional


class RecipeBase(BaseModel):
    """
    Recipe base schema
    """
    title: Optional[str]
    image_url: Optional[str]
    url: str
    author: Optional[User]


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
