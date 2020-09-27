FROM node:lts-alpine as build-step

ARG APP_ROOT=/app

RUN mkdir $APP_ROOT

WORKDIR $APP_ROOT

COPY package.json $APP_ROOT

RUN npm install

COPY . $APP_ROOT

RUN npm run build


FROM nginx:1.17.1-alpine

COPY --from=build-step /app/build /usr/share/nginx/html