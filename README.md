# Laravel Docky

Laravel Docky is an open source project for building lightweight, secure and fast local Laravel development environments using Docker.

## Security
To improve security of this environment, Docker images are build following these best practices:

- Each container should have only one responsibility.
- Harden the security of the service running within the container.
- Start the service with a non-root user privileges.
- Containers should be immutable, lightweight and fast.
- Use shared volumes.
- Containers should be easy to destroy and rebuild.
- Install only the minimum required packages for the service.
- Clean and remove cache hits during the build process.

For consistency, all Docker images are based on **Alpine Linux** and use only official images on Docker hub.

## Project Structure
```
Vue Docky
    │   
    └─── src   
    └─── nginx 
    │     │   certs     
    │     │   logs    
    │     │   nginxconf
    │     │   ssl
    │     └───Dockerfile
    └─── php 
    │     │   phpini     
    │     │   www.conf  
    │     └───Dockerfile
    └─── postgresql 
    │     │   postgres.conf  
    │     └───Dockerfile
    └─── docker-compose.yml
    └─── README.md
```

## Usage
To start using Laravel Docky, first make sur you have a current version of [Docker](https://docs.docker.com/get-docker/) installed on you host operating system.

Once you are inside the directory where you cloned this repository, run this command to build all Docker images and start the services:

```
$ docker-compose up -d --build
```

The following services are started with their ports exposed:

- nginx:
    - ``80``
    - ``443``
- php-fpm: ``9000``
- postgresql: ``5432``
- redis: ``6379``
- nginx:
    - ``1025``
    - ``8025``

Additionnaly, three containers are provided, each one handles a specific responsibility:

- Composer:

```
$ docker-compose run --rm composer <composer command>
```

- PHP Artisan:

```
$ docker-compose run --rm artisan <artisan command>
```

- npm:

```
$ docker-compose run --rm npm <npm command>
```

## Web Server - Nginx
Nginx service is running on the port ``80`` and configured with TLS v1.2 and TLS v1.3 enabled. Also, Nginx service is started with a non-root user.

**Note**: Mode Security nginx module is under configuration at the time of writing this documentation.


## PHP-FPM
PHP-FPM service is running on a individual container on the port ``9000``.
It is built with the ability to choose to enable PHP extensions among **34 available modules**. If desired, you can choose which extention you would like to enable by setting the ``ARG`` variable to ``1`` in the Dockerfile.

```
ARG PHP_INSTALL_EXT_PDO_PGSQL="1"
```

A list of php extension configuration files is provided with this project. These files are stored in ``php/phpini`` folder. You can add you custom php extension configuration that will be copied into the right php ini folder of the container.


## Artisan
Artisan CLI service is created from the PHP-FPM container. It allows to interact with your Laravel project by running this command:

```
$ docker-compose run --rm artisan <artisan command>
```


## Composer
Composer service is also based on Alpine linux and use the official Composer image on Docker hub.

This command allows to execute a composer command:

```
$ docker-compose run --rm composer <composer command>
```


## PostgreSQL

Data are persisted in the host machine so they will no get lost as soon as the container is stopped.
To set Postgresql parameters via the configuration file is to edit the ``posgtresql.conf``.


## npm
npm is the docker-compose service that provides npm capabilities via a simple command:

```
$ docker-compose run --rm npm <npm command>
```


### Set up Hot Reloading with ``npm run watch``
To set up a container watching for updates to your html, js, css files, run the following command:

```
$ docker-compose run --rm -p 3001:3001 -p 3000:3000 npm run watch
```

**Example:**
Benefiting from BronserSync with Laravel Mix you can use the configuration bellow to activate hot reloading:

```
//webpack.mix.js

mix.js('resources/js/app.js', 'public/js')
    .postCss('resources/css/app.css', 'public/css')
    .browserSync({
        proxy: 'webserver:80',
        open: false,
    })
```

## MailHog
MailHog is used by default by Laravel 8 for testing email sending over smtp in the local development. The service is started on the port 8025 by docker-compoe. The dashboard is accessible from ``localhost:8025``.

## Redis
Redis service is running on the port 6379.
