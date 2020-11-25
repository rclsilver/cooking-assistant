FROM python:3.8.3-alpine

# You can pass PIP_ENV=development to install development dependencies
ARG PIP_ENV=production

# Root directory
WORKDIR /usr/src

# Prevents Python from writing *.pyc files to disc
ENV PYTHONDONTWRITEBYTECODE 1

# Prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED 1

# Copy application
COPY . /usr/src

# Install application dependencies
RUN set -eux \
    && apk add --no-cache --virtual .build-deps build-base curl libressl-dev libffi-dev gcc musl-dev python3-dev postgresql-dev \
    && pip install --upgrade pip setuptools wheel \
    && pip install -r /usr/src/requirements/${PIP_ENV}.txt \
    && rm -rf /root/.cache/pip

# Expose application port
EXPOSE 8000

# Start the application
CMD /usr/src/docker-entrypoint.sh
