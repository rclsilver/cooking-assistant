from cooking_assistant import create_app
from flask_testing import TestCase


class CommonTestCase(TestCase):
    @classmethod
    def create_standalone_app(cls):
        return create_app(
            environment='test',
            config_file='config-test.yml'
        )

    def create_app(self):
        return self.create_standalone_app() 
