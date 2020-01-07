import json
from tests import CommonTestCase


class FunctionalTestCase(CommonTestCase):
    def call(self, method, uri, data=None):
        headers = {}

        if data is not None:
            data = json.dumps(data)
            headers['Content-Type'] = 'application/json'

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
