from app.schemas import BaseModel, Empty


class UserBase(BaseModel):
    """
    User base schema
    """
    username: str


class User(UserBase):
    """
    User full schema
    """
    pass
