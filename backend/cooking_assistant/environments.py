from cooking_assistant.extensions import cors, db, jsonschema, keycloak, ma, migrate
from cooking_assistant.logs import setup_loggers
from flask import Flask
from pathlib import Path


basedir = Path(__file__).resolve().parent


class Config(object):
    DEBUG = False
    JSONSCHEMA_DIR = basedir.joinpath('schemas')
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    @staticmethod
    def init_app(app: Flask) -> None:
        setup_loggers(app)
        db.init_app(app)
        ma.init_app(app)
        migrate.init_app(app, db)
        jsonschema.init_app(app)
        cors.init_app(app)
        keycloak.init_app(app)


class DevelopmentConfig(Config):
    DEBUG = True


class TestingConfig(Config):
    pass


class ProductionConfig(Config):
    pass


def get_config(environment: str) -> Config:
    return dict(
        dev=DevelopmentConfig,
        test=TestingConfig,
        prod=ProductionConfig,
    ).get(
        environment,
        ProductionConfig
    )
