FROM nginx:stable-alpine

LABEL maintainer="Ali Dalhouss <ali.dalhouss@gmail.com>"

RUN apk update \
    && apk upgrade \
    && apk --update add logrotate \
    && apk add --no-cache openssl \
    && apk add --no-cache bash

# ensure www-data user exists
RUN set -x ; \
    addgroup -g 82 -S www-data ; \
    adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

ADD ./nginxconf/laravel.conf /etc/nginx/conf.d/laravel.conf
COPY ./nginxconf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
