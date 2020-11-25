import datetime

from app.controllers import (
    AlreadyExistsException,
    ControllerException,
    LinkedResourceNotFoundException,
    NotFoundException,
    RequirementsNotSatisfiedException
)
from fastapi import Request, status
from fastapi.responses import JSONResponse
from typing import Dict, Type
from uuid import UUID


def serialize_context(context: Dict) -> str:
    """
    Serialize context to a JSON string
    """
    def _serialize(value: any) -> any:
        """
        Serialize any value to string
        """
        if isinstance(value, dict):
            return {
                k: _serialize(v) for k, v in value.items()
            }
        elif isinstance(value, list):
            return [
                _serialize(v) for v in value
            ]
        elif isinstance(value, type):
            return value.__name__
        elif isinstance(value, datetime.datetime):
            return value.strftime('%Y-%m-%dT%H:%M:%SZ')
        elif isinstance(value, datetime.date):
            return value.strftime('%Y-%d-%d')
        else:
            return str(value)
    return _serialize(context)


async def handle_controller_exceptions(request: Request, exc: ControllerException) -> JSONResponse:
    """
    Handle controller exceptions
    """
    if isinstance(exc, NotFoundException):
        status_code = status.HTTP_404_NOT_FOUND
    else:
        status_code = status.HTTP_409_CONFLICT

    return JSONResponse(
        status_code=status_code,
        content={
            'message': exc.message,
            'context': serialize_context(exc.context),
            'kind': exc.kind
        }
    )
