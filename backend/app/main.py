import logging
import os

from app import VERSION
from app.auth import configure_auth
from app.auth.oidc import OidcAuth
from app.controllers.user import UserController
from app.database import get_session
from app.routers import recipe, user
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


# Test
from app.schemas.user import User
from app.auth import get_user
from typing import Optional
@app.get('/me', response_model=Optional[User])
async def user_infos(user: User = Depends(get_user)):
    return user
# End Test


# Create the routes
app.include_router(recipe.router, prefix='/recipes')
app.include_router(user.router, prefix='/users')
