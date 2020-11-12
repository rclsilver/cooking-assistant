from app.models import Base
from sqlalchemy import Column, String


class User(Base):
    """
    User
    """
    username = Column(String, nullable=False, unique=True)
