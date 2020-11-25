import logging

from app.database import get_session
from app.schemas.user import User
from fastapi import Depends, Request
from sqlalchemy.orm import Session
from typing import ClassVar


_auth_instance = None


class AuthException(Exception):
    """
    Base authentication exception
    """
    pass


class AuthConfigureException(AuthException):
    """
    Auth configuration exception
    """
    pass


class BaseAuth:
    """
    Base auth class
    """
    
    def __init__(self):
        """
        Initialize the class
        """
        self._logger = logging.getLogger(f'{self.__class__.__module__}.{self.__class__.__name__}')

    def get_user(self, request: Request, db: Session) -> User:
        """
        Get or create user from authorization header
        """
        raise NotImplementedError()


def configure_auth(auth_cls: ClassVar, *args, **kwargs):
    """
    Configure auth
    """
    global _auth_instance
    _auth_instance = auth_cls(*args, **kwargs)


def get_auth() -> BaseAuth:
    """
    Get current auth instance
    """
    global _auth_instance
    return _auth_instance


def get_user(
    request: Request,
    auth: BaseAuth = Depends(get_auth),
    db: Session = Depends(get_session)
) -> User:
    """
    Get or create user from the request
    """
    return auth.get_user(request, db)
