from cooking_assistant.extensions import db
from tests.functional import FunctionalTestCase


class HealthFunctionalTest(FunctionalTestCase):
    def test_health(self):
        response = self.call(
            'GET',
            '/health'
        )
        self.assertStatus(response, 200)
        self.assertIsInstance(response.json, dict)
        self.assertIn('db', response.json)
        self.assertTrue(response.json['db'])

    def test_health_when_db_is_unavailable(self):
        self.app.config.update({
            'SQLALCHEMY_DATABASE_URI': 'postgresql://bad-user:bad-password@postgresql:5432/bad-db'
        })
        db.init_app(self.app)
        response = self.call(
            'GET',
            '/health'
        )
        self.assertStatus(response, 500)
        self.assertIsInstance(response.json, dict)
        self.assertIn('db', response.json)
        self.assertFalse(response.json['db'])
