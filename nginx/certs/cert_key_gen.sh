#!/bin/sh

#check if there is no existing certificate
if [ ! -f /etc/ssl/certs/laravel.test.crt ]; then
    # Create a self-signed key and certificate pair with OpenSSL.
    openssl genrsa -out "/etc/ssl/private/laravel.test.key" 4096
    openssl req -new -key "/etc/ssl/private/laravel.test.key" -out "/etc/ssl/certs/laravel.test.csr" -config "/etc/ssl/certs/ca_laravel_docky.cnf"
    openssl x509 -req -days 365 -in "/etc/ssl/certs/laravel.test.csr" -signkey "/etc/ssl/private/laravel.test.key" -out "/etc/ssl/certs/laravel.test.crt" -extensions server_cert -extfile "/etc/ssl/certs/ca_laravel_docky.cnf"
fi
