#!/usr/bin/env sh

if [ "${ALEMBIC_UPGRADE:-false}" == "true" ]
then
    echo "[alembic] Initialize or upgrade database..."
    PYTHONPATH=. alembic upgrade head
fi

if [ "${APP_ENV:-production}" == "development" ]
then
    echo "[development] Enabling hot reload and debug logs"
    UVICORN_DEV_OPTS="--reload --log-level debug"
fi

uvicorn app.main:app --workers 1 --host 0.0.0.0 --port 8000 ${UVICORN_DEV_OPTS}
