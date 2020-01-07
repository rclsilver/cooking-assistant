from cooking_assistant.api import api
from flask import current_app, jsonify, g, make_response, Response
from werkzeug.exceptions import BadRequest, Forbidden, InternalServerError, MethodNotAllowed, NotFound, Unauthorized


def format_error(kind: str, code: int, message: str) -> Response:
    content = {
        'errors': [
            {
                'kind': kind,
                'message': message,
                'context': {}
            }
        ]
    }

    response = make_response(jsonify(content), code)
    response.headers['X-Request-Id'] = g.request_id

    return response


@api.app_errorhandler(BadRequest)
def bad_request_handler(e: Exception) -> None:
    return format_error('BAD_REQUEST', 400, BadRequest.description)


@api.app_errorhandler(Unauthorized)
def unauthorized_handler(e: Exception) -> None:
    return format_error('UNAUTHORIZED', 401, Unauthorized.description)


@api.app_errorhandler(Forbidden)
def forbidden_handler(e: Exception) -> None:
    return format_error('FORBIDDEN', 403, Forbidden.description)


@api.app_errorhandler(NotFound)
def not_found_handler(e: Exception) -> None:
    return format_error('NOT_FOUND', 404, NotFound.description)


@api.app_errorhandler(MethodNotAllowed)
def method_not_allowed_handler(e: Exception) -> None:
    return format_error('METHOD_NOT_ALLOWED', 405, MethodNotAllowed.description)


@api.app_errorhandler(Exception)
def internal_server_error_handler(e: Exception) -> None:
    current_app.logger.exception(e)
    return format_error('INTERNAL_SERVER_ERROR', 500, InternalServerError.description)
