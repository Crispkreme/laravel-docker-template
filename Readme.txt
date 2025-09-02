// logging in the docker via cmd
docker-compose exec php bash

    - composer install
    - cp .env.example .env
    - php artisan key:generate
    - composer dump-autoload

// running the migration in the laravel app
docker-compose exec php php artisan migrate
