import datetime

from app.schemas import BaseModel, Empty
from app.schemas.recipe import RecipeSchedule
from app.schemas.user import User
from pydantic import validator
from typing import List, Optional


class PlanningDay(Empty):
    """
    Day of a planning
    """
    date: datetime.date
    schedules: List[RecipeSchedule]


class Planning(Empty):
    """
    Planning schema
    """
    start_date: datetime.date
    end_date: datetime.date
    days: List[PlanningDay]


class PlanningCreate(Empty):
    """
    New schedule payload
    """
    date: datetime.date
