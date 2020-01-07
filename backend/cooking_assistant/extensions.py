from flask_cors import CORS
from flask_jsonschema import JsonSchema
from flask_marshmallow import Marshmallow
from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy


db = SQLAlchemy(session_options={'autoflush': False})
ma = Marshmallow()
migrate = Migrate()
cors = CORS()
jsonschema = JsonSchema()
