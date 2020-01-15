from cooking_assistant.extensions import db
from tests.functional import FunctionalTestCase


class AuthFunctionalTest(FunctionalTestCase):
    def test_login_with_valid_credentials(self):
        response = self.call(
            'POST',
            '/auth/token',
            data={
                'username': self.credentials[0],
                'password': self.credentials[1]
            }
        )
        self.assertStatus(response, 200)
        self.assertIsInstance(response.json, dict)
        self.assertIn('access_token', response.json)
        self.assertIn('refresh_token', response.json)

    def test_login_with_invvalid_credentials(self):
        response = self.call(
            'POST',
            '/auth/token',
            data={
                'username': 'dummy',
                'password': 'dummy'
            }
        )
        self.assertErrorIs(response, 401, 'UNAUTHORIZED')

    def test_refresh_with_valid_token(self):
        response = self.call(
            'POST',
            '/auth/token/refresh',
            data={
                'refresh-token': self.token['refresh_token']
            }
        )
        self.assertStatus(response, 200)
        self.assertIsInstance(response.json, dict)
        self.assertIn('access_token', response.json)
        self.assertIn('refresh_token', response.json)

    def test_refresh_with_invalid_token(self):
        response = self.call(
            'POST',
            '/auth/token/refresh',
            data={
                'refresh-token': 'dummy'
            }
        )
        self.assertErrorIs(response, 401, 'UNAUTHORIZED')

    def test_logout_with_valid_token(self):
        response = self.call(
            'DELETE',
            '/auth/token',
            data={
                'refresh-token': self.token['refresh_token']
            }
        )
        self.assertStatus(response, 204)

    def test_logout_with_invalid_token(self):
        response = self.call(
            'DELETE',
            '/auth/token',
            data={
                'refresh-token': 'dummy'
            }
        )
        self.assertStatus(response, 204)

    def test_my_profile_with_valid_token(self):
        response = self.call(
            'GET',
            '/auth/profile',
            access_token=self.token['access_token']
        )
        self.assertStatus(response, 200)
        self.assertIsInstance(response.json, dict)
        self.assertIn('email', response.json)
        self.assertIn('email_verified', response.json)
        self.assertIn('family_name', response.json)
        self.assertIn('given_name', response.json)
        self.assertIn('name', response.json)
        self.assertIn('preferred_username', response.json)
        self.assertIn('sub', response.json)

    def test_my_profile_with_invalid_token(self):
        response = self.call(
            'GET',
            '/auth/profile'
        )
        self.assertErrorIs(response, 401, 'UNAUTHORIZED')
