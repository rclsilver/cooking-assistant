import re

from app.models import Base
from typing import Dict, Optional, Type
from sqlalchemy.orm import Query, Session
from typing import Dict, Optional
from uuid import UUID


class ControllerException(Exception):
    """
    Base controller exception
    """
    def __init__(self, message: str, context: Dict = {}, kind: Optional[str] = None):
        """
        Exception constructor
        """
        self.message = message.format(**context)
        self.context = context
        if kind:
            self.kind = kind

    def __str__(self):
        """
        Return the message as string representation
        """
        return self.message


class NotFoundException(ControllerException):
    """
    Resource does not exist
    """
    pass


class AlreadyExistsException(ControllerException):
    """
    Resource already exists
    """
    pass


class LinkedResourceNotFoundException(ControllerException):
    """
    Linked resource does not exist
    """
    pass


class RequirementsNotSatisfiedException(ControllerException):
    """
    Requirements are not satisfied
    """
    pass


EXCEPTIONS = (
    'NotFoundException',
    'AlreadyExistsException',
    'LinkedResourceNotFoundException',
    'RequirementsNotSatisfiedException'
)


class ControllerMeta(type):
    """
    Metaclass used to provided class exceptions respecting inheritance.
    Example:
    >>> class A(metaclass=ModelMeta):
    ...     pass
    >>> class B(A):
    ...     pass
    >>> class C(A):
    ...     pass
    >>>
    >>> try:
    ...     raise B.NoObjectsReturned("b")
    ... except A.NoObjectsReturned as e:
    ...     print(e)
    b
    >>> try:
    ...     raise B.NoObjectsReturned("b")
    ... except C.NoObjectsReturned as e:
    ...     print(e)
    Traceback (most recent call last):
        File "<console>", line 2, in <module>
    NoObjectsReturned: b
    """

    def __new__(cls, name, bases, attrs):
        """Dynamically create a new class to inherit from.

        This function is fairly simple once you understood the type object
        See http://goo.gl/ka8voA for some explanations
        Makes exceptions in EXCEPTIONS appear in each Controller subclass.
        Creates a unique kind string in the exception to identify its type.
        """
        super_new = super(ControllerMeta, cls).__new__
        kind_prefix = name.split('Controller')[0]
        for exception in EXCEPTIONS:
            kind_suffix = re.sub(r'([A-Z]+)', r'_\1', exception.split('Exception')[0])
            kind = kind_prefix + kind_suffix
            attrs[exception] = type(
                exception,
                tuple(getattr(x, exception) for x in bases if hasattr(x, exception)) or (eval(exception),),
                {
                    'kind': kind.upper()
                }
            )
        return super_new(cls, name, bases, attrs)


class BaseController(metaclass=ControllerMeta):
    """
    Base controller class
    """
    @classmethod
    def _get(cls, db: Session, model_cls: Type[Base], **filters) -> Type[Base]:
        """
        Fetch one resource or raise NotFoundException if not found
        """
        result = db.query(model_cls).filter_by(**filters).first()

        if not result:
            raise cls.NotFoundException('{resource_type} not found', {
                'resource_type': model_cls.__name__,
                'filters': filters
            })

        return result

    @classmethod
    def _get_foreign(cls, db: Session, model_cls: Type[Base], **filters) -> Type[Base]:
        """
        Fetch one resource or raise LinkedResourceNotFoundException if not found
        """
        result = db.query(model_cls).filter_by(**filters).first()

        if not result:
            raise cls.LinkedResourceNotFoundException('{resource_type} not found', {
                'resource_type': model_cls.__name__,
                'filters': filters
            })

        return result

    @classmethod
    def _raise_if_already_exists(cls, query: Query, message: Optional[str] = None, kind: Optional[str] = None, **fields):
        """
        Raise an AlreadyExistsException if query returns result
        """
        result = query.first()

        if result:
            if not message:
                message = '{resource_type} already exists'

            raise cls.AlreadyExistsException(
                message,
                {
                    'resource_type': type(result).__name__,
                    'resource_id': result.id,
                    'fields': [ k for k, _ in fields.items() ]
                },
                kind
            )
