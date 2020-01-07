FROM python:3.8-alpine

# Container settings
ENTRYPOINT [ "./docker-entrypoint.sh" ]
EXPOSE 5000

# Set application folder
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install requirements
ADD requirements/* /usr/src/app/requirements/
RUN apk add postgresql-dev gcc python3-dev musl-dev && \
    pip install --no-cache-dir -r requirements/production.txt

# Copy application
COPY . /usr/src/app
