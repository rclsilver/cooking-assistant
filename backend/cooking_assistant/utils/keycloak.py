import functools
import keycloak
import re
import typing
from flask import abort, Flask, request, request_started
from keycloak.exceptions import KeycloakAuthenticationError, KeycloakGetError


class Keycloak(object):
    TOKEN_RE = re.compile(r'^Bearer (?P<token>.+)')

    def __init__(self) -> None:
        self._keycloak = None

    def init_app(self, app: Flask) -> None:
        self._keycloak = keycloak.KeycloakOpenID(
            server_url=app.config.get('KEYCLOAK_URL'),
            realm_name=app.config.get('KEYCLOAK_REALM'),
            client_id=app.config.get('KEYCLOAK_CLIENT'),
            client_secret_key=app.config.get('KEYCLOAK_CLIENT_SECRET')
        )
        request_started.connect(self.get_user_info, app)

    def get_user_info(self, app: Flask) -> None:
        m = self.TOKEN_RE.match(request.headers.get('Authorization', ''))

        if m:
            try:
                request.user = self._keycloak.userinfo(m.group('token'))
            except (KeycloakAuthenticationError, KeycloakGetError):
                request.user = None
        else:
            request.user = None

    def login(self, username: str, password: str) -> dict:
        try:
            return self._keycloak.token(username, password)
        except KeycloakAuthenticationError:
            abort(401)

    def refresh(self, refresh_token: str) -> dict:
        try:
            return self._keycloak.refresh_token(refresh_token)
        except KeycloakGetError:
            abort(401)

    def logout(self, refresh_token: str) -> None:
        try:
            self._keycloak.logout(refresh_token)
        except KeycloakGetError:
            pass

    def require_token(self, func: typing.Callable) -> typing.Callable:
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            if request.user is None:
                abort(401)
            return func(*args, **kwargs)
        return wrapper
