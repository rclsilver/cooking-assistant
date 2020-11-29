from app.models import Base
from sqlalchemy import Column, Date, ForeignKey, func, UniqueConstraint
from sqlalchemy.orm import backref, relationship
from sqlalchemy.dialects.postgresql import UUID


class RecipeSchedule(Base):
    """
    Recipe schedule
    """
    __tablename__ = 'recipe_schedule'

    date = Column(Date(), default=func.now(), nullable=False, index=True)

    # Recipe relation
    recipe_id = Column(UUID, ForeignKey('recipe.id'), nullable=False)
    recipe = relationship('Recipe', backref=backref('schedules', uselist=True))

    # Author relation
    author_id = Column(UUID, ForeignKey('user.id'), nullable=False)
    author = relationship('User', backref=backref('schedules', uselist=True))

    # Table args
    __table_args__ = (
        UniqueConstraint('recipe_id', 'date', name='recipe_date_uc'),
    )
