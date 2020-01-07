import colorlog
import flask
import logging
import time


def setup_loggers(app: flask.Flask) -> None:
    """Setup loggers for a production environment"""
    # Flask lazily initializes its logger, it must be called here so we can
    # change its configuration
    _ = app.logger

    for logger_name in ('', app.name):
        logger = logging.getLogger(logger_name)
        logger.setLevel(logging.DEBUG)

        # Clean all existing handlers
        logger.handlers = list()

    # Add stdout handler
    logging.getLogger().addHandler(get_stdout_handler())

    # Add a custom log for each Flask request
    flask.request_started.connect(log_prerequest, app)
    flask.request_finished.connect(log_postrequest, app)

    # Remove Gunicorn access log to not get the info twice
    logging.getLogger('gunicorn.access').handlers = []


def log_prerequest(app: flask.Flask, **kwargs) -> None:
    flask.g.request_start_time = time.time()
    flask.g.is_admin = False


def log_postrequest(app: flask.Flask, **kwargs) -> None:
    response = kwargs['response']
    execution_time = time.time() - flask.g.get('request_start_time')
    execution_time = round(execution_time, 3)
    msg = '{} {} {} {}s'.format(
        flask.request.method, flask.request.path,
        response.status_code, execution_time
    )
    app.logger.info(
        msg,
        extra={
            'execution_time': execution_time,
            'response_status_code': response.status_code,
            'response_content_length': response.content_length
        }
    )


def get_stdout_handler() -> logging.Handler:
    handler = colorlog.StreamHandler()
    formatter = colorlog.ColoredFormatter(
        '%(log_color)s%(levelname)s%(reset)s [%(asctime)s] %(message)s',
        log_colors={
            'INFO': 'cyan',
            'WARNING': 'yellow',
            'ERROR': 'red',
            'CRITICAL': 'white,bg_red'
        }
    )
    handler.setFormatter(formatter)
    return handler
