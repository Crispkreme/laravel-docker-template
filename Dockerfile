FROM php:8.3 AS php

# Install dependencies
RUN apt-get update -y && \
    apt-get install -y unzip libpq-dev libcurl4-gnutls-dev libssl-dev libzip-dev && \
    docker-php-ext-install pdo pdo_mysql bcmath

# Install Redis extension
RUN pecl install redis && \
    docker-php-ext-enable redis

# Set working directory
WORKDIR /var/www

# Copy application files
# COPY . /var/www
COPY . .

# Copy composer binary
COPY --from=composer:2.5 /usr/bin/composer /usr/bin/composer

# Install MySQL client for connectivity testing (optional)
RUN apt-get update && apt-get install -y default-mysql-client

# Set environment variables
ENV PORT=8000

# Set entrypoint script
ENTRYPOINT ["/var/www/docker/entrypoint.sh"]

# ==========================================================================================
# NODE.JS

FROM node:14-alpine AS node

# Set working directory
WORKDIR /var/www

# Copy application files
COPY . .

RUN npm install --global cross-env
RUN npm install

VOLUME /var/www/node_modules
