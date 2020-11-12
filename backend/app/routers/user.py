import uuid

from app.controllers.user import UserController
from app.database import get_session
from app.schemas.user import User
from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException ,Path
from sqlalchemy.orm import Session
from typing import List


router = APIRouter()


@router.get('/', response_model=List[User])
async def get_users(
    db: Session = Depends(get_session)
):
    """
    Get users list
    """
    return UserController.get_users(db)


@router.delete('/{user_id}', status_code=204)
async def delete_user(
    user_id: uuid.UUID = Path(..., title='User ID'),
    db: Session = Depends(get_session)
):
    """
    Delete a user
    """
    user = UserController.get_user_by_id(user_id, db)
    
    if not user:
        raise HTTPException(404, f'User with ID {user_id} not found')

    UserController.delete_user(user, db)
