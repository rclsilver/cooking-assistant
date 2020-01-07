import typing
from cooking_assistant.api import api
from cooking_assistant.extensions import db


@api.route('/health')
def health() -> typing.Tuple[dict, int]:
    ''' Get the API health '''
    result = {}

    # Check database
    try:
        db.session.execute('SELECT 1')
        result['db'] = True
    except Exception:
        result['db'] = False

    # Return result
    return result, 200 if all(result.values()) else 500
