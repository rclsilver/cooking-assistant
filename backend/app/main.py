import os

from app import VERSION
from app.controllers.user import UserController
from app.database import get_session
from app.routers import recipe, user
from fastapi import Depends, FastAPI, Request, Response
from sqlalchemy.orm import Session
from typing import Callable


# Is production
production = os.getenv('APP_ENV', 'production') == 'production'

# Create our FastAPI application
app = FastAPI(
    title='Cooking-Assistant',
    version=VERSION,
    debug=not production,
    root_path='/api'
)

# Create the routes
app.include_router(recipe.router, prefix='/recipes')
app.include_router(user.router, prefix='/users')
