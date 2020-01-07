#!/usr/bin/env python
import os

from cooking_assistant import create_app
from flask_migrate import MigrateCommand
from flask_script import Manager, Shell

app = create_app(
    os.getenv('APP_CONFIG', 'config.yml'),
    os.getenv('APP_ENV', 'default')
)


def main() -> None:
    manager = Manager(app)
    manager.add_command('shell', Shell(make_context=lambda: dict(app=app)))
    manager.add_command('db', MigrateCommand)
    manager.run()


if '__main__' == __name__:
    main()
