from app.schemas import BaseModel, Empty
from pydantic import validator
from typing import Optional


class UnitBase(BaseModel):
    """
    Unit base schema
    """
    label: str
    label_plural: Optional[str]


class Unit(UnitBase):
    """
    Unit full schema
    """
    pass


class UnitCreate(Empty):
    """
    Unit create schema
    """
    label: str
    label_plural: Optional[str]

    @validator('label')
    def label_must_be_valid(cls, value: str):
        """
        Validate label field value
        """
        if not value.strip():
            raise ValueError('Label cannot be empty')
        return value.strip()


class UnitUpdate(UnitCreate):
    """
    Unit update schema
    """
    pass
