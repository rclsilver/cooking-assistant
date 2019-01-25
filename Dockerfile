FROM python:3.7

ENV COOKING_ASSISTANT_VERSION 1.0.0

ENTRYPOINT ["./docker-entrypoint.sh"]
EXPOSE 8080

RUN mkdir /code
WORKDIR /code

ADD requirements/* /code/requirements/
RUN pip install --no-cache-dir  -r requirements/production.txt

COPY . /code

RUN python /code/manage.py collectstatic --noinput
