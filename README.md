# Why Laravel Docker Boilerplate?

- 🚀 Quick Start: Get your Laravel application up and running in minutes with minimal setup.
- 🛠️ Full-Stack Support: Includes configurations for PHP, Nginx, MySQL/PostgreSQL, Redis, and more.
- 🔒 Secure & Scalable: Implements Docker best practices for security and performance.
- 🔧 Customizable: Easily adaptable to fit any Laravel project, from small apps to enterprise-scale solutions.

# Key Features

- Multi-Environment Support: Smoothly transition between development, staging, and production environments.
- Pre-Configured Services:
  - PHP (optimized for Laravel).
  - Nginx web server.
  - Database options: MySQL, PostgreSQL.
  - Redis for caching and queues.
- Docker Compose Integration: Simplify container orchestration with a well-structured docker-compose.yml.
- Developer-Friendly Tools:
  - Xdebug for debugging.
  - Artisan CLI and Composer directly from the container.
- Optimized for CI/CD: Ready for seamless integration with GitHub Actions, GitLab CI/CD, or other pipelines.

## Security

To improve security of this environment, Docker images on this project are built following these best practices:

- Each container should have only one responsibility.
- Harden the security of the service running within the container.
- Start the service with a non-root user privileges.
- Containers should be immutable, lightweight and fast.
- Use shared volumes.
- Containers should be easy to destroy and rebuild.
- Install only the minimum required packages for the service.
- Clean and remove cache hits during the build process.

For consistency, all Docker images are based on **Alpine Linux** and use only official images from Docker hub.

## Project Structure

```
Laravel Docker Boilerplate
      │
      └─── src
      └─── nginx
      │     │   certs
      │     │   logs
      │     │   conf
      │     │   ssl
      │     └───Dockerfile
      └─── php
      │     │   phpini
      │     │   conposer
      │     │   www.conf
      │     └───Dockerfile
      └─── postgresql
      │     │   postgres.conf
      │     └───Dockerfile
      └─── docker-compose.yml
      └─── README.md
```

## Usage

To start using Laravel Docker Boilerplate, first make sur you have a current version of [Docker](https://docs.docker.com/get-docker/) installed on you host operating system.

Once you are inside the directory where you cloned this repository, run this command to build all Docker images and start the services:

```
$ docker-compose up -d --build
```

The following services are started with their respective ports exposed:

- nginx:
  - `80`
  - `443`
- php-fpm: `9000`
- postgresql: `5432`
- redis: `6379`
- mailhog:
  - `1025`
  - `8025`

Additionnaly, three containers are provided with this project, each one handles a specific responsibility:

### Composer:

```
$ docker exec -it php-app composer <composer command>
```

### PHP Artisan:

```
$ docker exec -it php-app php artisan <artisan command>
```

### npm:

```
$ docker-compose run --rm npm <npm command>
```

## Web Server - Nginx

Nginx service is running on the port `443` and configured with TLS v1.2 and TLS v1.3 enabled. Also, Nginx service is started with a non-root user.

**Note**: Mode Security nginx module is under configuration at the time of writing this documentation.

## PHP-FPM

PHP-FPM service is running on a individual container on the port `9000`.
It is built with the ability to choose to enable PHP extensions among **34 available modules**. If desired, you can choose which extention you would like to enable by setting the `ARG` variable to `1` in the Dockerfile.

```
ARG PHP_INSTALL_EXT_PDO_PGSQL="1"
```

### List of available PHP modules:

|         |           |           |              |         |
| :-----: | :-------: | :-------: | :----------: | :-----: |
| BCMATH  |    BZ2    | CALENDAR  |     DBA      |   DOM   |
| ENCHANT |   EXIF    |    FFI    |      GD      | GETTEXT |
|   GMP   |   IMAP    |   INTL    |     LDAP     | MYSQLI  |
|  PCNTL  | PDO_MYSQL | PDO_PGSQL |    PGSQL     |  SHMOP  |
|  SNMP   |   SOAP    |  SOCKETS  |   SYSVMSG    | SYSVSEM |
| SYSVSHM |   TIDY    |    XSL    | ZEND_OPCACHE |   ZIP   |

A list of php extension configuration files is provided with this project. These files are stored in `php/phpini` folder. You can add your custom php extension configuration that will be copied into the right php ini folder of the container.

## Artisan

Artisan CLI service allows to interact with your Laravel project by running this command:

```
$ ddocker exec -it php-app php artisan <artisan command>
```

## Composer

Composer service is part of the PHP contrainer
This command allows to execute a composer command:

```
$ docker exec -it php-app composer <composer command>
```

## PostgreSQL

Data are persisted in the host machine so they will not get lost as soon as the container is stopped.
To set PostgreSQL parameters via the configuration file is to edit the `posgtresql.conf`.

## npm

npm is the docker-compose service that provides npm capabilities via a simple command:

```
$ docker-compose run --rm npm <npm command>
```

### Set up Hot Module Replacement with Vite `npm run dev`

To set up a container watching for updates to your html, blade, js and css files, run the following command:

```
$ docker-compose run --rm -p 5173:5173 npm run dev
```

#### ❗️**Important**:

You should update your `vite.config.js` to look like this:

```
//vite.config.js

import laravel from "laravel-vite-plugin";
import { defineConfig } from "vite";

export default defineConfig({
    plugins: [
        laravel({
            input: ["resources/css/app.css", "resources/js/app.js"],
            refresh: true,
        }),
    ],
    server: {
        host: true,
        hmr: {
            host: "localhost",
        },
        watch: {
            usePolling: true,
        },
    },
});

```

Second, don't forget to add `@vite(['resources/css/app.css', 'resources/js/app.js'])` inside your blade `head` tag.

## Mailpit

Mailpit is included for testing email sending over smtp in the local development. The service is started on the port 8025 by docker-compoe. The dashboard is accessible from `localhost:8025`.
Here is the configuration of Laravel .env file for Mailpit:

```
AIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"
```

## Redis

Redis service is running on the port 6379.
