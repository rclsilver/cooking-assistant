from app.auth import get_user
from app.controllers.ingredient import IngredientController
from app.database import get_session
from app.routers import admin_required
from app.schemas.ingredient import Ingredient, IngredientCreate, IngredientUpdate
from app.schemas.user import User
from fastapi import APIRouter, Body, Depends, Path, Response, status
from sqlalchemy.orm import Session
from typing import List
from uuid import UUID


router = APIRouter()


@router.get('/', response_model=List[Ingredient])
async def get_ingredients(
    db: Session = Depends(get_session)
) -> List[Ingredient]:
    """
    Get ingredients list
    """
    return IngredientController.get_ingredients(db)


@router.post('/', response_model=Ingredient)
@admin_required
async def create_ingredient(
    payload: IngredientCreate = Body(..., title='Ingredient payload'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> Ingredient:
    """
    Create an ingredient
    """
    return IngredientController.create_ingredient(payload, db)


@router.put('/{ingredient_id}', response_model=Ingredient)
@admin_required
async def update_ingredient(
    ingredient_id: UUID = Path(..., title='Ingredient ID'),
    payload: IngredientUpdate = Body(..., title='Ingredient payload'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> Ingredient:
    """
    Update an ingredient
    """
    ingredient = IngredientController.get_ingredient(ingredient_id, db)
    return IngredientController.update_ingredient(ingredient, payload, db)


@router.delete('/{ingredient_id}', response_class=Response, status_code=status.HTTP_204_NO_CONTENT)
@admin_required
async def delete_ingredient(
    ingredient_id: UUID = Path(..., title='Ingredient ID'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> None:
    """
    Delete an ingredient
    """
    ingredient = IngredientController.get_ingredient(ingredient_id, db)
    IngredientController.delete_ingredient(ingredient, db)
