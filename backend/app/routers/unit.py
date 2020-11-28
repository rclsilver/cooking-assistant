from app.auth import get_user
from app.controllers.unit import UnitController
from app.database import get_session
from app.routers import admin_required
from app.schemas.unit import Unit, UnitCreate, UnitUpdate
from app.schemas.user import User
from fastapi import APIRouter, Body, Depends, Path, Response, status
from sqlalchemy.orm import Session
from typing import List
from uuid import UUID


router = APIRouter()


@router.get('/', response_model=List[Unit])
async def get_units(
    db: Session = Depends(get_session)
) -> List[Unit]:
    """
    Get units list
    """
    return UnitController.get_units(db)


@router.post('/', response_model=Unit)
@admin_required
async def create_unit(
    payload: UnitCreate = Body(..., title='Unit payload'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> Unit:
    """
    Create an unit
    """
    return UnitController.create_unit(payload, db)


@router.put('/{unit_id}', response_model=Unit)
@admin_required
async def update_unit(
    unit_id: UUID = Path(..., title='Unit ID'),
    payload: UnitUpdate = Body(..., title='Unit payload'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> Unit:
    """
    Update an unit
    """
    unit = UnitController.get_unit(unit_id, db)
    return UnitController.update_unit(unit, payload, db)


@router.delete('/{unit_id}', response_class=Response, status_code=status.HTTP_204_NO_CONTENT)
@admin_required
async def delete_unit(
    unit_id: UUID = Path(..., title='Unit ID'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> None:
    """
    Delete an unit
    """
    unit = UnitController.get_unit(unit_id, db)
    UnitController.delete_unit(unit, db)
