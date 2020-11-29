import logging
import os

from app import errors, VERSION
from app.auth import configure_auth
from app.auth.oidc import OidcAuth
from app.controllers import ControllerException
from app.controllers.user import UserController
from app.database import get_session
from app.routers import planning, recipe, user
from fastapi import Depends, FastAPI, Header, Request, Response
from sqlalchemy.orm import Session
from typing import Callable


# Is production
production = os.getenv('APP_ENV', 'production') == 'production'

# Configure logging
logging.basicConfig(
    level=logging.INFO if production else logging.DEBUG
)

# Initialize auth configuration
configure_auth(OidcAuth, os.getenv('OIDC_ISSUER'))

# Create our FastAPI application
app = FastAPI(
    title='Cooking-Assistant',
    version=VERSION,
    debug=not production,
    root_path='/api'
)

# Handle errors
app.add_exception_handler(ControllerException, errors.handle_controller_exceptions)

# Create the routes
app.include_router(planning.router, prefix='/planning')
app.include_router(recipe.router, prefix='/recipes')
app.include_router(user.router, prefix='/users')
