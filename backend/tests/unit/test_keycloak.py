from cooking_assistant.utils.keycloak import Keycloak
from flask import request
from tests.mock.keycloak import KeycloakOpenIDMock
from tests.unit import UnitTestCase
from unittest.mock import MagicMock, patch
from werkzeug.exceptions import Unauthorized


class KeycloakUnitTest(UnitTestCase):
    def setUp(self):
        super(KeycloakUnitTest, self).setUp()
        self.keycloak = Keycloak()
        self.keycloak._keycloak = KeycloakOpenIDMock()

    def test_get_user_info_without_header(self):
        self.keycloak.get_user_info(None)
        self.assertIsNone(request.user)

    def test_get_user_info_with_valid_token(self):
        username, password = self.keycloak._keycloak.generate_account()
        token = self.keycloak._keycloak.token(username, password)
        access_token = token['access_token']
        request.headers = { 'Authorization': f'Bearer {access_token}' }
        self.keycloak.get_user_info(None)
        self.assertIsNotNone(request.user)

    def test_get_user_info_with_invalid_token(self):
        request.headers = { 'Authorization': f'Bearer invalid-token' }
        self.keycloak.get_user_info(None)
        self.assertIsNone(request.user)

    def test_login_with_valid_credentials(self):
        username, password = self.keycloak._keycloak.generate_account()
        token = self.keycloak.login(username, password)
        self.assertIsNotNone(token)

    def test_login_with_invalid_credentials(self):
        with self.assertRaises(Unauthorized):
            self.keycloak.login('dummy', 'dummy')

    def test_refresh_with_valid_token(self):
        username, password = self.keycloak._keycloak.generate_account()
        token = self.keycloak.login(username, password)
        self.keycloak.refresh(token['refresh_token'])

    def test_refresh_with_invvalid_token(self):
        with self.assertRaises(Unauthorized):
            self.keycloak.refresh('dummy')

    def test_logout_with_valid_token(self):
        username, password = self.keycloak._keycloak.generate_account()
        token = self.keycloak.login(username, password)
        self.keycloak.logout(token['refresh_token'])

    def test_logout_with_invvalid_token(self):
        self.keycloak.logout('dummy')

    def test_require_token_with_user(self):
        request.user = 'dummy'
        self.assertEquals(self.keycloak.require_token(lambda: 'dummy')(), 'dummy')

    def test_require_token_without_user(self):
        request.user = None
        with self.assertRaises(Unauthorized):
            self.keycloak.require_token(lambda: 'dummy')()
