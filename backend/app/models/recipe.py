from app.models import Base
from sqlalchemy import Boolean, Column, ForeignKey, Float, Integer, String, UniqueConstraint
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


class RecipeIngredient(Base):
    """
    An ingredient in a recipe
    """
    __tablename__ = 'recipe_ingredient'

    quantity = Column(Float, nullable=True)
    optional = Column(Boolean, default=False)

    # Recipe relation
    recipe_id = Column(UUID, ForeignKey('recipe.id'), nullable=False)
    recipe = relationship('Recipe', backref=backref('ingredients', uselist=True))

    # Ingredient relation
    ingredient_id = Column(UUID, ForeignKey('ingredient.id'), nullable=False)
    ingredient = relationship('Ingredient', backref=backref('recipes', uselist=True))

    # Unit relation
    unit_id = Column(UUID, ForeignKey('unit.id'), nullable=True)
    unit = relationship('Unit')

    # Table args
    __table_args__ = (
        UniqueConstraint('recipe_id', 'ingredient_id', name='recipe_ingredient_uc'),
    )


class RecipeStep(Base):
    """
    A step of a recipe
    """
    __tablename__ = 'recipe_step'

    order = Column(Integer, nullable=False)
    content = Column(String, nullable=False)

    # Recipe relation
    recipe_id = Column(UUID, ForeignKey('recipe.id'), nullable=False)
    recipe = relationship('Recipe', backref=backref('steps', uselist=True, order_by='RecipeStep.order.asc()'))

    # Table args
    __table_args__ = (
        UniqueConstraint('recipe_id', 'order', name='recipe_order_uc'),
    )
