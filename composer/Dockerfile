FROM composer:latest

LABEL maintainer="Ali Dalhouss <ali.dalhouss@gmail.com>"

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel
USER laravel
WORKDIR /var/www/html
