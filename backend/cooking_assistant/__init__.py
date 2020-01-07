import codecs
import importlib
import pkgutil
import types
import typing
import uuid
import yaml
from cooking_assistant.environments import get_config
from cooking_assistant.exceptions import ConfigurationException
from flask import Flask, g
from pathlib import Path


MODULES_TO_IMPORT = ('api', 'controllers', 'models')


def read_config(config_file: str) -> dict:
    file_path = Path(config_file)

    # Check that the configuration file is readable
    if not file_path.is_file():
        raise ConfigurationException('Missing configuration file')

    try:
        with open(config_file, 'r'):
            pass
    except IOError:
        raise ConfigurationException('Cannot read configuration file')

    # Loading configuration
    with codecs.open(config_file, 'r', 'utf8') as file_handler:
        return yaml.load(file_handler, Loader=yaml.SafeLoader)


def create_app(
    config_file: str = 'config.yml',
    environment: str = 'default'
) -> Flask:
    config = get_config(environment)

    # Create the application
    app = Flask(__name__)

    # Load default vars from environment
    app.config.from_object(config)

    # Load vars from config file
    app.config.update(
        read_config(config_file)
    )

    # Load environment extensions
    config.init_app(app)

    # Register blueprints
    from .api import api as api_blueprint
    app.register_blueprint(api_blueprint, url_prefix='/')

    # Generates request ID for each request
    @app.before_request
    def before_api_request():
        g.request_id = str(uuid.uuid4())

    @app.after_request
    def after_api_request(response):
        response.headers['X-Request-Id'] = g.request_id
        return response

    return app


def import_submodules(
    package: typing.Union[str, types.ModuleType],
    modules_to_import: list
) -> typing.Dict[str, types.ModuleType]:
    '''Import all submodules of a module, recursively, including subpackages'''

    if isinstance(package, str):
        package = importlib.import_module(package)
    results = {}

    for loader, name, is_pkg in pkgutil.walk_packages(package.__path__):
        if not name.startswith("_"):
            full_name = package.__name__ + '.' + name

            if any((x in package.__name__ for x in modules_to_import)):
                results[full_name] = importlib.import_module(full_name)

            elif any((x in name for x in modules_to_import)):
                results[full_name] = importlib.import_module(full_name)

            if is_pkg and name in modules_to_import:
                results.update(import_submodules(full_name, modules_to_import))
    return results


import_submodules(__name__, MODULES_TO_IMPORT)
