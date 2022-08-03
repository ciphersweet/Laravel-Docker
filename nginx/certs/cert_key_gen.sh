#!/bin/sh

#check if there is no existing certificate
if [ ! -f /etc/nginx/ssl/laravel.test.crt ] 
then
    # Create a self-signed key and certificate pair with OpenSSL.
    openssl genrsa -out "/etc/nginx/ssl/laravel.test.key" 4096
    openssl req -new -key "/etc/nginx/ssl/laravel.test.key" -out "/etc/nginx/ssl/laravel.test.csr" -config "/etc/nginx/ssl/ca_laravel_docky.cnf"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/laravel.test.csr" -signkey "/etc/nginx/ssl/laravel.test.key" -out "/etc/nginx/ssl/laravel.test.crt" -extensions server_cert -extfile "/etc/nginx/ssl/ca_laravel_docky.cnf"
fi
