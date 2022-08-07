FROM php:8.1.0-fpm-alpine3.15

LABEL maintainer="Ali Dalhouss <ali.dalhouss@gmail.com>"

# Image Build PHP extension list
ARG PHP_INSTALL_EXT_BCMATH="1"
ARG PHP_INSTALL_EXT_BZ2="0"
ARG PHP_INSTALL_EXT_CALENDAR="1"
ARG PHP_INSTALL_EXT_DBA="0"
ARG PHP_INSTALL_EXT_DOM="0"
ARG PHP_INSTALL_EXT_ENCHANT="0"
ARG PHP_INSTALL_EXT_EXIF="0"
ARG PHP_INSTALL_EXT_FFI="0"
ARG PHP_INSTALL_EXT_GD="0"
ARG PHP_INSTALL_EXT_GETTEXT="0"
ARG PHP_INSTALL_EXT_GMP="0"
ARG PHP_INSTALL_EXT_IMAP="0"
ARG PHP_INSTALL_EXT_INTL="0"
ARG PHP_INSTALL_EXT_LDAP="0"
ARG PHP_INSTALL_EXT_MYSQLI="0"
#ARG PHP_INSTALL_EXT_ODBC="1"
ARG PHP_INSTALL_EXT_PCNTL="0"
#ARG PHP_INSTALL_EXT_PDO_DBLIB="1"
#ARG PHP_INSTALL_EXT_PDO_ODBC="1"
ARG PHP_INSTALL_EXT_PDO_MYSQL="0"
ARG PHP_INSTALL_EXT_PDO_PGSQL="1"
ARG PHP_INSTALL_EXT_PGSQL="1"
#ARG PHP_INSTALL_EXT_PSPELL="1"
ARG PHP_INSTALL_EXT_SHMOP="0"
ARG PHP_INSTALL_EXT_SNMP="0"
ARG PHP_INSTALL_EXT_SOAP="0"
ARG PHP_INSTALL_EXT_SOCKETS="0"
ARG PHP_INSTALL_EXT_SYSVMSG="0"
ARG PHP_INSTALL_EXT_SYSVSEM="0"
ARG PHP_INSTALL_EXT_SYSVSHM="0"
ARG PHP_INSTALL_EXT_TIDY="0"
ARG PHP_INSTALL_EXT_XSL="0"
ARG PHP_INSTALL_EXT_ZEND_OPCACHE="1"
ARG PHP_INSTALL_EXT_ZIP="0"

# Install Depencencies --------------------------------------------------------
RUN apk add --update --no-cache -t .php-run-deps \
    # ffi
    libffi \
    # gd
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    # gmp
    gmp \
    # imap
    imap-dev \
    krb5-dev \
    # intl
    icu-libs \
    libintl \
    # zip
    libzip \
    #libzip for bz2
    libbz2 \
    # libxml for dom
    libxml2 \
    # Other tools
    git \
    patch && \
    # Install Build Dependencies ----------------------------------------------
    apk add --update --no-cache --virtual .php-build-deps \
    # ffi
    libffi-dev \
    # gettext
    gettext-dev \
    # gmp
    gmp-dev \
    openssl-dev \
    # intl
    icu-dev \
    # mbstring
    oniguruma-dev \
    # XML
    libxml2-dev \
    ldb-dev \
    # Zip \
    libzip-dev \
    # Bzip2 for bz2
    bzip2-dev \
    # Pecl \
    autoconf \
    g++ \
    make \
    # APCu
    pcre-dev \
    # Other
    wget && \
    # Install PHP extensions --------------------------------------------------
    # bcmath
    if [ "${PHP_INSTALL_EXT_BCMATH}" == "1" ]; then \
    docker-php-ext-install \
    bcmath --ini bcmath.php.ini; \
    fi && \
    # bz2
    if [ "${PHP_INSTALL_EXT_BCMATH}" == "1" ]; then \
    docker-php-ext-install \
    bz2 --ini bz2.php.ini; \
    fi && \
    # calendar
    if [ "${PHP_INSTALL_EXT_CALENDAR}" == "1" ]; then \
    docker-php-ext-install \
    calendar --ini calendar.php.ini; \
    fi && \
    # dba
    if [ "${PHP_INSTALL_EXT_DBA}" == "1" ]; then \
    docker-php-ext-install \
    dba --ini dba.php.ini; \
    fi && \
    # dom
    if [ "${PHP_INSTALL_EXT_DBA}" == "1" ]; then \
    docker-php-ext-install \
    dom --ini dom.php.ini; \
    fi && \
    # enchant
    if [ "${PHP_INSTALL_EXT_ENCHANT}" == "1" ]; then \
    # enchant run dependancies
    apk add --update --no-cache \
    enchant2; \
    # enchant build dependancies
    apk add --update --no-cache --virtual .php-enchant-build-deps \
    enchant2-dev; \
    docker-php-ext-install \
    enchant --ini enchant.php.ini; \
    fi &&\
    # exif
    if [ "${PHP_INSTALL_EXT_EXIF}" == "1" ]; then \
    docker-php-ext-install \
    exif --ini exif.php.ini; \
    fi &&\
    # ffi
    if [ "${PHP_INSTALL_EXT_FFI}" == "1" ]; then \
    docker-php-ext-install \
    ffi --ini ffi.php.ini; \
    fi  &&\
    # gd
    if [ "${PHP_INSTALL_EXT_GD}" == "1" ]; then \
    docker-php-ext-install \
    gd --ini gd.php.ini; \
    fi &&\
    # gettext
    if [ "${PHP_INSTALL_EXT_GETTEXT}" == "1" ]; then \
    docker-php-ext-install \
    gettext --ini gettext.php.ini; \
    fi &&\
    # gmp
    if [ "${PHP_INSTALL_EXT_GMP}" == "1" ]; then \
    docker-php-ext-install \
    gmp --ini gmp.php.ini; \
    fi &&\
    # imap
    if [ "${PHP_INSTALL_EXT_IMAP}" == "1" ]; then \
    NPROC=$(getconf _NPROCESSORS_ONLN); \
    PHP_OPENSSL=yes; \
    docker-php-ext-configure \
    imap --with-kerberos --with-imap-ssl; \
    docker-php-ext-install "-j${NPROC}" \
    imap --ini imap.php.ini; \
    fi &&\
    # intl
    if [ "${PHP_INSTALL_EXT_INTL}" == "1" ]; then \
    docker-php-ext-install \
    intl --ini intl.php.ini; \
    fi &&\
    # ldap
    if [ "${PHP_INSTALL_EXT_LDAP}" == "1" ]; then \
    # ldap run dependencies
    apk add --update --no-cache \
    libldap; \
    # ldap build dependencies
    apk add --update --no-cahe --virtual .php-ldap-build-deps \
    openldap-dev; \
    docker-php-ext-install \
    ldap --ini ldap.php.ini; \ 
    apk del .php-ldap-build-deps ;\
    fi &&\
    # mysqli
    if [ "${PHP_INSTALL_EXT_MYSQLI}" == "1" ]; then \
    docker-php-ext-install \
    mysqli --ini mysqli.php.ini; \ 
    fi &&\
    # pcntl
    if [ "${PHP_INSTALL_EXT_PCNTL}" == "1" ]; then \
    docker-php-ext-install \
    pcntl --ini pcntl.php.ini; \ 
    fi &&\
    # pdo_mysql
    if [ "${PHP_INSTALL_EXT_PDO_MYSQL}" == "1" ]; then \
    docker-php-ext-install \
    pdo_mysql --ini pdo_mysql.php.ini; \ 
    fi &&\
    # pdo_pgsql
    if [ "${PHP_INSTALL_EXT_PDO_PGSQL}" == "1" ]; then \
    # postgresql run dependancies
    apk add --update --no-cache \
    libpq; \
    # postgresql build dependencies
    apk add --update --no-cache --virtual .php-postgresql-build-deps \
    postgresql-client \
    postgresql-dev; \
    docker-php-ext-install \
    pdo_pgsql --ini pdo_pgsql.php.ini \
    pgsql --ini pgsql.php.ini; \
    apk del .php-postgresql-build-deps; \
    fi &&\
    # shmop
    if [ "${PHP_INSTALL_EXT_SHMOP}" == "1" ]; then \
    docker-php-ext-install \
    shmop --ini shmop.php.ini; \ 
    fi &&\
    # snmp
    if [ "${PHP_INSTALL_EXT_SNMP}" == "1" ]; then \
    # snmp run dependancies
    apk add --update --no-cache \
    net-snmp; \
    # snmp build dependencies
    apk add --update --no-cache --virtual .php-snmp-build-deps \
    net-snmp-dev; \
    docker-php-ext-install \
    snmp --ini snmp.php.ini; \
    apk del .php-snmp-build-deps; \
    fi &&\
    # soap
    if [ "${PHP_INSTALL_EXT_SOAP}" == "1" ]; then \
    # soap run dependancies
    apk add --update --no-cache \
    libxml2; \
    # soap build dependencies
    apk add --update --no-cache --virtual .php-soap-build-deps \
    libxml2-dev; \
    docker-php-ext-install \
    soap --ini soap.php.ini; \
    apk del .php-soap-build-deps; \
    fi && \
    # sockets 
    if [ "${PHP_INSTALL_EXT_SOCKETS}" == "1" ]; then \
    docker-php-ext-install \
    sockets --ini sockets.php.ini; \
    fi && \
    # sysvmsg 
    if [ "${PHP_INSTALL_EXT_SYSVMSG}" == "1" ]; then \
    docker-php-ext-install \
    sysvmsg --ini sysvmsg.php.ini; \
    fi && \
    # sysvsem 
    if [ "${PHP_INSTALL_EXT_SYSVSEM}" == "1" ]; then \
    docker-php-ext-install \
    sysvsem --ini sysvsem.php.ini; \
    fi && \
    # sysvshm 
    if [ "${PHP_INSTALL_EXT_SYSVSHM}" == "1" ]; then \
    docker-php-ext-install \
    sysvshm --ini sysvshm.php.ini; \
    fi && \
    # tidy
    if [ "${PHP_INSTALL_EXT_TIDY}" == "1" ]; then \
    # tidy run dependencies
    apk add --update --no-cache \
    tidyhtml; \
    # tidy build dependencies
    apk add --update --no-cache --virtual .php-tidy-build-deps \
    tidyhtml-dev; \
    docker-php-ext-install \
    tidy --ini tidy.php.ini; \
    apk del .php-tidy-build-deps; \
    fi &&\
    # xsl
    if [ "${PHP_INSTALL_EXT_XSL}" == "1" ]; then \ 
    # xsl run dependancies
    apk add --update --no-cache \
    libcslt; \
    # xsl build dependancies 
    apk add --update --no-cache --virtual .php-xsl-build-deps \
    libxslt-dev; \
    docker-php-ext-install \
    xsl --ini xsl.php.ini; \
    apk del .php-xsl-build-deps; \
    fi && \
    # Zend Opcache
    if [ "${PHP_INSTALL_EXT_ZEND_OPCACHE}" == "1" ]; then \ 
    docker-php-ext-install \
    opcache --ini opcache.php.ini; \
    fi && \
    # zip
    if [ "${PHP_INSTALL_EXT_ZIP}" == "1" ]; then \ 
    docker-php-ext-install \
    zip --ini zip.php.ini; \
    fi

# Big clean
RUN apk del .php-build-deps && \
    rm -rf /var/cache/apk/* && \
    docker-php-source delete

ADD ./phpini/ "$PHP_INI_DIR"/conf.d/
ADD ./www.conf /usr/local/etc/php-fpm.d/www.conf

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel
RUN chown laravel:laravel /var/www/html

COPY ./composer/composer-installer.sh /opt/composer-installer.sh
RUN /bin/sh /opt/composer-installer.sh

USER laravel

COPY php_loaded_extensions.php /var/www/html/php_loaded_extensions.php

RUN php -f /var/www/html/php_loaded_extensions.php
RUN rm -f /var/www/html/php_loaded_extensions.php

EXPOSE 9000/tcp
