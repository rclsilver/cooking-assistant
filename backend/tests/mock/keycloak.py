import random
import string
import typing
import uuid
from flask import Flask
from keycloak.exceptions import KeycloakAuthenticationError, KeycloakGetError


def random_string(length: int) -> str:
    return ''.join(random.choice(string.ascii_letters) for i in range(length))


class KeycloakOpenIDMock(object):
    _credentials = {}
    _userinfo = {}
    _refresh_tokens = {}

    def __init__(self, *args, **kwargs) -> None:
        pass

    def generate_account(self) -> typing.Tuple[str, str]:
        access_token = str(uuid.uuid4())
        refresh_token = str(uuid.uuid4())
        username = random_string(16)
        password = random_string(16)
        first_name = random_string(16)
        last_name = random_string(16)
        self._credentials[username] = {
            'password': password,
            'tokens': {
                'access_token': access_token,
                'refresh_token': refresh_token
            }
        }
        self._userinfo[access_token] = {
            'sub': str(uuid.uuid4()),
            'preferred_username': username,
            'email': f'{username}@example.com',
            'email_verified': True,
            'family_name': last_name,
            'given_name': first_name,
            'name': f'{first_name} {last_name}'
        }
        self._refresh_tokens[refresh_token] = access_token
        return (username, password)

    def token(self, username: str, password: str) -> dict:
        if username not in self._credentials:
            raise KeycloakAuthenticationError()
        if password != self._credentials[username]['password']:
            raise KeycloakAuthenticationError()
        return self._credentials[username]['tokens']

    def userinfo(self, access_token: str) -> dict:
        if access_token not in self._userinfo:
            raise KeycloakGetError()
        return self._userinfo[access_token]

    def refresh_token(self, refresh_token: str) -> dict:
        if refresh_token not in self._refresh_tokens:
            raise KeycloakGetError()
        for credential in self._credentials.values():
            if credential['tokens']['refresh_token'] == refresh_token:
                return credential['tokens']

    def logout(self, refresh_token: str) -> None:
        if refresh_token not in self._refresh_tokens:
            raise KeycloakGetError()
        access_token = self._refresh_tokens[refresh_token]
        del self._refresh_tokens[refresh_token]
        del self._userinfo[access_token]
        self._credentials = {
            username: credential for username, credential in self._credentials.items() if credential['tokens']['access_token'] != access_token
        }
