import typing
from cooking_assistant.api import api
from cooking_assistant.extensions import keycloak
from flask import request
from flask_jsonschema import validate


@api.route('/auth/token', methods=['POST'])
@validate('auth', 'login')
def login() -> typing.Dict:
    return keycloak.login(
        request.json.get('username'),
        request.json.get('password')
    )


@api.route('/auth/token/refresh', methods=['POST'])
@validate('auth', 'refresh')
def refresh() -> typing.Dict:
    return keycloak.refresh(request.json.get('refresh-token'))


@api.route('/auth/token', methods=['DELETE'])
@validate('auth', 'logout')
def logout() -> typing.Tuple[str, int]:
    keycloak.logout(request.json.get('refresh-token'))
    return '', 204


@api.route('/auth/profile')
@keycloak.require_token
def me() -> typing.Tuple[dict, int]:
    return request.user, 200
