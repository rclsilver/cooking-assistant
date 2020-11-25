from app.auth import get_user
from app.controllers.user import UserController
from app.database import get_session
from app.routers import admin_required
from app.schemas.user import User
from fastapi import APIRouter, Depends, Path, Response, status
from sqlalchemy.orm import Session
from typing import List
from uuid import UUID


router = APIRouter()


@router.get('/', response_model=List[User])
async def get_users(
    db: Session = Depends(get_session)
) -> List[User]:
    """
    Get users list
    """
    return UserController.get_users(db)


@router.delete('/{user_id}', response_class=Response, status_code=status.HTTP_204_NO_CONTENT)
@admin_required
async def delete_user(
    user_id: UUID = Path(..., title='User ID'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> None:
    """
    Delete a user
    """
    user = UserController.get_user_by_id(user_id, db)
    UserController.delete_user(user, db)
