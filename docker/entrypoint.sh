#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV"
    cp .env.example .env
else
    echo "ENV file exists"
fi

#$role can be found in the docker-compose.yaml
role=$CONTAINER_ROLE
if [ "$role" = "app"  ]; then

    php artisan key:generate
    php artisan migrate
    php artisan optimize:clear

elif [ "$role" = "queue"  ]; then

    echo "running the queue ...."
    php /var/www/artisan queue:work --verbose --tries=3 --timeout=18

elif [ "$role" = "websocket"  ]; then

    echo "running the websocket server ...."
    php artisan websockets:serve

fi

php artisan serve --port=$PORT --host=0.0.0 --env=.env
exec docker-php-entrypoint "$@"
