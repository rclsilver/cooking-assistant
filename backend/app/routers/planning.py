import datetime

from app.auth import get_user
from app.controllers.planning import PlanningController
from app.database import get_session
from app.schemas.planning import Planning
from app.schemas.user import User
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session


router = APIRouter()


@router.get('/', response_model=Planning)
async def get_planning(
    start_date: datetime.date = Query(..., title='Start date'),
    end_date: datetime.date = Query(..., title='End date'),
    user: User = Depends(get_user),
    db: Session = Depends(get_session)
) -> Planning:
    """
    Get planning between `start_date` and `end_date`
    """
    return PlanningController.get_planning(start_date, end_date, db)
