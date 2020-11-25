from app.auth import get_user
from app.controllers.recipe import RecipeController
from app.controllers.user import UserController
from app.database import get_session
from app.routers import admin_required
from app.schemas.recipe import Recipe, RecipeImport
from app.schemas.user import User
from fastapi import APIRouter, BackgroundTasks, Body, Depends, HTTPException, Path, Response, status
from sqlalchemy.orm import Session
from typing import List, Optional
from uuid import UUID


router = APIRouter()


@router.get('/', response_model=List[Recipe])
async def get_recipes(
    db: Session = Depends(get_session)
) -> List[Recipe]:
    """
    Get recipes list
    """
    return RecipeController.get_recipes(db)


@router.get('/{recipe_id}', response_model=Recipe)
async def get_recipe(
    recipe_id: UUID = Path(..., title='Recipe ID'),
    db: Session = Depends(get_session)
) -> Recipe:
    """
    Get a recipe
    """
    return RecipeController.get_recipe(recipe_id, db)


@router.post('/import', response_model=Recipe)
async def import_recipe(
    background_tasks: BackgroundTasks,
    payload: RecipeImport = Body(..., title='Payload'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> Recipe:
    """
    Import a recipe from an URL
    """
    recipe = RecipeController.import_recipe(payload, user, db)
    background_tasks.add_task(RecipeController.fetch_recipe_informations, recipe, db)
    return recipe


@router.delete('/{recipe_id}', response_class=Response, status_code=status.HTTP_204_NO_CONTENT)
@admin_required
async def delete_recipe(
    recipe_id: UUID = Path(..., title='Recipe ID'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> None:
    """
    Delete a recipe
    """
    recipe = RecipeController.get_recipe(recipe_id, db)
    RecipeController.delete_recipe(recipe, db)
