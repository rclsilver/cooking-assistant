from app.controllers import BaseController
from app.models.unit import Unit
from app.models.recipe import RecipeIngredient
from app.schemas.unit import UnitCreate, UnitUpdate
from sqlalchemy.orm import Session
from typing import List
from uuid import UUID


class UnitController(BaseController):
    """
    Unit controller
    """

    @classmethod
    def get_units(cls, db: Session) -> List[Unit]:
        """
        Fetch all units from database
        """
        return db.query(Unit).all()

    @classmethod
    def get_unit(cls, unit_id: UUID, db: Session) -> Unit:
        """
        Fetch a specific unit from database
        """
        return cls._get(db, Unit, id=unit_id)

    @classmethod
    def create_unit(cls, payload: UnitCreate, db: Session) -> Unit:
        """
        Create an unit
        """
        cls._raise_if_already_exists(
            db.query(Unit).filter_by(label=payload.label),
            'Unit already exists with this label',
            label=payload.label
        )

        unit = Unit()
        unit.label = payload.label
        unit.label_plural = payload.label_plural

        db.add(unit)
        db.commit()

        return unit

    @classmethod
    def update_unit(cls, unit: Unit, payload: UnitUpdate, db: Session) -> Unit:
        """
        Update an unit
        """
        cls._raise_if_already_exists(
            db.query(Unit).filter_by(label=payload.label).filter(Unit.id != unit.id),
            'Unit already exists with this label',
            label=payload.label
        )

        unit.label = payload.label
        unit.label_plural = payload.label_plural

        db.add(unit)
        db.commit()

        return unit

    @classmethod
    def delete_unit(cls, unit: Unit, db: Session) -> None:
        """
        Delete a unit from database
        """
        if db.query(RecipeIngredient).filter_by(unit=unit).first():
            raise cls.RequirementsNotSatisfiedException('This unit is still used by at least one recipe')

        db.delete(unit)
        db.commit()
