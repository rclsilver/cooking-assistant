#!/bin/bash
set -e

python /code/manage.py migrate

if [[ ${DJANGO_ENVIRONMENT} != "production" ]]; then
    python /code/manage.py loaddata /code/fixtures/*.json
fi

APP_TYPE=${APP_TYPE:=webui}

if [[ ${APP_TYPE} = "webui" ]]; then
    gunicorn \
        -w 5 \
        --bind=0.0.0.0:8080 \
        --access-logfile=- \
        --timeout=30 \
        cooking_assistant.wsgi:application
elif [[ ${APP_TYPE} = "celery-beat" ]]; then
    celery -A cooking_assistant beat -l info
elif [[ ${APP_TYPE} = "celery-worker" ]]; then
    celery -A cooking_assistant worker -l info
else
    echo "Wrong value for 'APP_TYPE' parameter: ${APP_TYPE}"
    exit 1
fi
