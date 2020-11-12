import datetime
import pydantic
import uuid


class Empty(pydantic.BaseModel):
    """
    Empty schema
    """
    pass


class BaseModel(Empty):
    """
    Base class about a model for FastAPI
    """
    id: uuid.UUID
    created_at: datetime.datetime
    updated_at: datetime.datetime

    class Config:
        orm_mode = True
