from app.controllers.recipe import RecipeController
from app.controllers.user import UserController
from app.database import get_session
from app.schemas.recipe import Recipe, RecipeCreate
from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException, Path
from sqlalchemy.orm import Session
from typing import List, Optional
from uuid import UUID


router = APIRouter()


@router.get('/', response_model=List[Recipe])
async def get_recipes(
    db: Session = Depends(get_session)
):
    """
    Get recipes list
    """
    return RecipeController.get_recipes(db)


@router.post('/', response_model=Recipe)
async def create_recipe(
    payload: RecipeCreate,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_session)
):
    """
    Create a new recipe
    """
    if RecipeController.get_recipe_by_url(payload.url, db):
        raise HTTPException(409, [
            {
                'loc': [ 'body', 'url' ],
                'msg': 'Recipe with URL already exists',
                'type': 'already_exists'
            }
        ])
    recipe = RecipeController.create_recipe(payload, db)
    background_tasks.add_task(RecipeController.fetch_recipe_informations, recipe, db)
    return recipe


@router.delete('/{recipe_id}', status_code=204)
async def delete_recipe(
    recipe_id: UUID = Path(..., title='Recipe ID'),
    db: Session = Depends(get_session)
):
    """
    Delete a recipe
    """
    recipe = RecipeController.get_recipe_by_id(recipe_id, db)
    
    if not recipe:
        raise HTTPException(404, f'Recipe with ID {recipe_id} not found')

    RecipeController.delete_recipe(recipe, db)
