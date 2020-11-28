from app.models import Base
from sqlalchemy import Column, String
from sqlalchemy.sql import expression


class Ingredient(Base):
    """
    Ingredient
    """
    label = Column(String, nullable=False, unique=True)
    label_plural = Column(String, nullable=True)
    image_url = Column(String, nullable=True)
