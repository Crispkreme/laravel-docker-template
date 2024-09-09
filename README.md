## Set up of laravel docker file

- run the docker before starting
- create a folder for your docker file

Terminal: `Ubuntu`  
Command:  
```sh

    cd folder # go to folder you want to create your projects
    mkdir folder_name # project folder
    touch Dockerfile # creating a docker file
    touch docker-compose.yml
    mkdir docker
    touch entrypoint.sh # inside the docker folder

    # go to github clone the repo

    docker compose up --build -d
    
```

## Creating the database in docker file

Terminal: `Ubuntu`  
Command:  
```sh

    docker compose ps

    # NAME (CONTAINER_NAME)              | IMAGE                     | COMMAND                  | SERVICE    | CREATED         | STATUS         | PORTS
    # project-web-portfolio-database-1   | mysql:8.0                 | "docker-entrypoint.sâ¦"  | database   | 2 minutes ago   | Up 2 minutes   | 33060/tcp, 0.0.0.0:3307->3306/tcp, :::3307->3306/tcp
    # project-web-portfolio-php-1        | project-web-portfolio-php | "/var/www/docker/entâ¦"  | php        | 2 minutes ago   | Up 2 minutes   | 0.0.0.0:9000->8000/tcp, :::9000->8000/tcp
    # project-web-portfolio-redis-1      | redis:alpine              |"docker-entrypoint.sâ¦"   | redis      | 2 minutes ago   | Up 2 minutes   | 0.0.0.0:6379->6379/tcp, :::6379->6379/tcp


    # if it has an error run the logs commands
    docker compose logs <CONTAINER_NAME>
    
    # create database in docker cmd
    docker exec -it <CONTAINER_NAME> mysql -u root -p

    # mysql password 
    root

    # my sql commands
    SHOW DATABASES;
    CREATE DATABASE project_web_portfolio;
    EXIT;

    # run the command to make sure all the data is not lost when stopping the docker
    # mounting the data into the docker location
    docker run --name project-web-portfolio-database-1 -e MYSQL_ROOT_PASSWORD=root -v /my/local/path:/var/lib/mysql -d mysql:latest
    
```
