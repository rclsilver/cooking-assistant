from app.models import Base
from sqlalchemy import Column, ForeignKey, String
from sqlalchemy.orm import backref, relationship
from sqlalchemy.dialects.postgresql import UUID


class Recipe(Base):
    """
    Recipe
    """
    title = Column(String, nullable=True)
    image_url = Column(String, nullable=True)
    url = Column(String, unique=True, nullable=False)

    # Author relation
    author_id = Column(UUID, ForeignKey('user.id'), nullable=True)
    author = relationship('User', backref=backref('recipes', uselist=True))
