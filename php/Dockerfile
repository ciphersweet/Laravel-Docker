FROM php:8.0.0-fpm-alpine

LABEL maintainer="Ali Dalhouss <ali.dalhouss@gmail.com>"

RUN docker-php-ext-install bcmath opcache;

EXPOSE 9000/tcp

ADD ./phpini/ "$PHP_INI_DIR/conf.d/"
ADD ./www.conf /usr/local/etc/php-fpm.d/www.conf

RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html
WORKDIR /var/www/html

COPY php_loaded_extensions.php /var/www/html/php_loaded_extensions.php

RUN php -f /var/www/html/php_loaded_extensions.php
RUN rm -f /var/www/html/php_loaded_extensions.php

EXPOSE 9000/tcp
