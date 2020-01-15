import json
from cooking_assistant.utils.keycloak import Keycloak
from tests import CommonTestCase
from tests.mock.keycloak import KeycloakOpenIDMock
from unittest.mock import patch


class FunctionalTestCase(CommonTestCase):
    @classmethod
    def setUpClass(cls):
        cls.keycloak_mock = patch('keycloak.KeycloakOpenID', KeycloakOpenIDMock)
        cls.keycloak_mock.start()

    @classmethod
    def tearDownClass(cls):
        cls.keycloak_mock.stop()

    def setUp(self):
        self.create_standalone_app().logger.info('setUp')
        self.keycloak = Keycloak()
        self.keycloak.init_app(self.create_standalone_app())
        self.credentials = self.keycloak._keycloak.generate_account()
        self.token = self.keycloak.login(*self.credentials)

    def call(self, method, uri, data=None, access_token=None):
        headers = {}

        if data is not None:
            data = json.dumps(data)
            headers['Content-Type'] = 'application/json'

        if access_token is not None:
            headers['Authorization'] = f'Bearer {access_token}'

        return getattr(
            self.client,
            method.lower()
        )(
            uri,
            data=data,
            headers=headers
        )

    def assertError(self, response):
        self.assertGreater(response.status_code, 399)
        self.assertLessEqual(response.status_code, 500)
        data = response.json
        self.assertIn('errors', data)
        self.assertIsInstance(data['errors'], list)
        self.assertGreaterEqual(len(data['errors']), 1)
        self.assertIsInstance(data['errors'][0], dict)
        self.assertIn('context', data['errors'][0])
        self.assertIsInstance(data['errors'][0]['context'], dict)
        self.assertIn('kind', data['errors'][0])
        self.assertIsInstance(data['errors'][0]['kind'], str)
        self.assertIn('message', data['errors'][0])
        self.assertIsInstance(data['errors'][0]['message'], str)
        self.assertIn('X-Request-Id', response.headers)

    def assertErrorIs(self, response, status, kind):
        self.assertError(response)
        self.assertStatus(response, status)
        self.assertEqual(response.json['errors'][0]['kind'], kind)
