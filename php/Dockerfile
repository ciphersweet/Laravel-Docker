FROM php:8.0.0-fpm-alpine

LABEL maintainer="Ali Dalhouss <ali.dalhouss@gmail.com>"

# Install dependencies for php extensions.
RUN apk add -U --no-cache --virtual .build-dependencies \
    # Dev dependencies
    autoconf \
    g++ \
    file \
    make \
    zlib-dev \
    libtool \
    libc-dev \
    libmemcached-dev \
    # Prod dependencies
    && apk add --no-cache \
    bash \
    gcc \
    pkgconf \
    libmemcached \
    # PHP extensions
    && docker-php-source extract \
    && docker-php-ext-install bcmath opcache pdo_mysql \
    && pecl install memcached redis \
    # Enable PHP extensions
    && docker-php-ext-enable memcached opcache redis \
    # Cleanup
    && apk del .build-dependencies && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/* /usr/share/doc/* /usr/share/man/*;

ADD ./phpini/ "$PHP_INI_DIR/conf.d/"
ADD ./www.conf /usr/local/etc/php-fpm.d/www.conf

RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html
WORKDIR /var/www/html

COPY php_loaded_extensions.php /var/www/html/php_loaded_extensions.php

RUN php -f /var/www/html/php_loaded_extensions.php
RUN rm -f /var/www/html/php_loaded_extensions.php

EXPOSE 9000/tcp
