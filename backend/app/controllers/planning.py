import datetime
import logging

from app.controllers import BaseController
from app.models.planning import RecipeSchedule
from app.schemas.planning import Planning, PlanningDay
from app.schemas.recipe import Recipe, RecipeSchedule as RecipeScheduleSchema
from app.schemas.user import User
from sqlalchemy import between
from sqlalchemy.orm import Session
from typing import List
from uuid import UUID


logger = logging.getLogger(__name__)


class PlanningController(BaseController):
    """
    Planning controller
    """

    @classmethod
    def get_scheduled_recipes(cls, start_date: datetime.date, end_date: datetime.date, db: Session) -> List[RecipeSchedule]:
        """
        Fetch all schedules between `start_date` and `end_date`
        """
        return db.query(RecipeSchedule).filter(RecipeSchedule.date.between(start_date, end_date))

    @classmethod
    def get_planning(cls, start_date: datetime.date, end_date: datetime.date, db: Session) -> Planning:
        """
        Build a planning between `start_date` and `end_date`
        """
        scheduled_recipes = cls.get_scheduled_recipes(start_date, end_date, db).order_by('date')

        recipes = list(
            RecipeScheduleSchema(
                id=scheduled_recipe.id,
                created_at=scheduled_recipe.created_at,
                updated_at=scheduled_recipe.updated_at,
                recipe=scheduled_recipe.recipe,
                author=scheduled_recipe.author,
                date=scheduled_recipe.date
            ) for scheduled_recipe in scheduled_recipes
        )

        days = list(
            PlanningDay(
                date=date,
                schedules=list(recipe for recipe in recipes if recipe.date == date)
            ) for date in (
                start_date + datetime.timedelta(days=i) for i in range((end_date - start_date).days + 1)
            )
        )

        return Planning(
            start_date=start_date,
            end_date=end_date,
            days=days
        )

    @classmethod
    def get_schedule(cls, recipe: Recipe, schedule_id: UUID, db: Session) -> RecipeSchedule:
        """
        Get a schedule by id
        """
        return cls._get(db, RecipeSchedule, recipe=recipe, id=schedule_id)
