# development stage (lts-alpine)
FROM node:12.16.0-alpine3.11 as devel-stage
WORKDIR /app
COPY . /app/
RUN mkdir /tmp/node_modules && ln -s /tmp/node_modules /app/node_modules

# build application (lts-alpine)
FROM node:12.16.0-alpine3.11 as build-stage
WORKDIR /app
COPY . /app/
RUN npm install
RUN npm run-script build

# build final image
FROM nginx:1.19.4-alpine
COPY --from=build-stage /app/dist/cooking-assistant /usr/share/nginx/html
