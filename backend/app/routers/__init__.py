from functools import wraps
from fastapi import HTTPException, status


def admin_required(func):
    """
    Return a HTTP 403 response if user is not an administrator
    """
    @wraps(func)
    async def wrapper(*args, **kwargs):
        if 'user' not in kwargs or not kwargs['user'].is_admin:
            raise HTTPException(status.HTTP_403_FORBIDDEN, 'You are not allowed to perform this action')
        return await func(*args, **kwargs)
    return wrapper
