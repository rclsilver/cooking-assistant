from app.auth import get_user
from app.controllers.planning import PlanningController
from app.controllers.recipe import RecipeController
from app.controllers.user import UserController
from app.database import get_session
from app.routers import admin_required
from app.schemas.planning import PlanningCreate
from app.schemas.recipe import Recipe, RecipeImport, RecipeSchedule
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


@router.post('/{recipe_id}/schedules', response_model=RecipeSchedule)
async def create_schedule(
    recipe_id: UUID = Path(..., title='Recipe ID'),
    payload: PlanningCreate = Body(..., title='Schedule payload'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> RecipeSchedule:
    """
    Schedule a recipe
    """
    recipe = RecipeController.get_recipe(recipe_id, db)
    return RecipeController.add_recipe_schedule(recipe, user, payload, db)


@router.get('/{recipe_id}/schedules', response_model=List[RecipeSchedule])
async def get_schedules(
    recipe_id: UUID = Path(..., title='Recipe ID'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> RecipeSchedule:
    """
    Get list of recipe schedules
    """
    return RecipeController.get_recipe(recipe_id, db).schedules


@router.delete('/{recipe_id}/schedules/{schedule_id}', response_class=Response, status_code=status.HTTP_204_NO_CONTENT)
async def delete_schedule(
    recipe_id: UUID = Path(..., title='Recipe ID'),
    schedule_id: UUID = Path(..., title='Schedule ID'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> None:
    """
    Delete a recipe schedule
    """
    recipe = RecipeController.get_recipe(recipe_id, db)
    schedule = PlanningController.get_schedule(recipe, schedule_id, db)
    RecipeController.remove_recipe_schedule(schedule, db)
