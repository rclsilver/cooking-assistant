from app.models import Base
from sqlalchemy import Boolean, Column, String
from sqlalchemy.sql import expression


class User(Base):
    """
    User
    """
    username = Column(String, nullable=False, unique=True)
    is_admin = Column(Boolean, nullable=False, server_default=expression.false(), default=False)
