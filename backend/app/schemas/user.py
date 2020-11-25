from app.schemas import BaseModel, Empty


class UserBase(BaseModel):
    """
    User base schema
    """
    username: str
    is_admin: bool


class User(UserBase):
    """
    User full schema
    """
    pass
