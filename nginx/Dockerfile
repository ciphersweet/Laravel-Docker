FROM nginx:stable-alpine

LABEL maintainer="Ali Dalhouss <ali.dalhouss@gmail.com>"

ADD ./nginxconf/laravel.conf /etc/nginx/conf.d/laravel.conf
COPY ./nginxconf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN chown laravel:laravel /var/www/html

WORKDIR /var/www/html
