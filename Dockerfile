FROM python:3.7

ENV COOKING_ASSISTANT_VERSION 1.0.0

ENTRYPOINT ["./docker-entrypoint.sh"]
EXPOSE 8080

RUN apt-get update && \
    apt-get install -yqq apt-transport-https && \
    echo "deb https://deb.nodesource.com/node_11.x/ stretch main" >> /etc/apt/sources.list && \
    wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list && \
    wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -yqq nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /code
WORKDIR /code

ADD requirements/* /code/requirements/
RUN pip install --no-cache-dir  -r requirements/production.txt

COPY . /code

RUN cd /code/frontend && \
    /usr/bin/npm install && \
    /usr/bin/npm run build

RUN python /code/manage.py collectstatic --noinput
