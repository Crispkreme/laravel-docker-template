FROM php:8.3-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    unzip \
    git \
    curl

# Install PHP extensions required by Laravel
RUN docker-php-ext-install pdo pdo_mysql bcmath

# Install Composer globally
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html