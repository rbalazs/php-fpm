FROM php:7.2.30-fpm

WORKDIR /app

RUN apt-get update && apt-get install -y apt-utils vim curl net-tools dialog zip bash git && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql

RUN pecl install xdebug && docker-php-ext-enable xdebug

COPY --from=composer:1.1 /usr/bin/composer /usr/bin/composer

RUN usermod -u 1000 www-data

RUN mkdir -p /run/php/ && chown -R www-data:www-data /run/php/

EXPOSE 9000
