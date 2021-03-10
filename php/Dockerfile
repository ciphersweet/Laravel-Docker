FROM php:8-fpm-alpine

LABEL maintainer="Ali Dalhouss <ali.dalhouss@gmail.com>"

RUN docker-php-ext-install bcmath --ini bcmath.php.ini\
    opcache --ini opcache.php.ini;

ADD ./phpini/ "$PHP_INI_DIR"/conf.d/
ADD ./www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel
RUN chown laravel:laravel /var/www/html

USER laravel

COPY php_loaded_extensions.php /var/www/html/php_loaded_extensions.php

RUN php -f /var/www/html/php_loaded_extensions.php
RUN rm -f /var/www/html/php_loaded_extensions.php

EXPOSE 9000/tcp
