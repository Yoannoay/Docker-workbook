#!/bin/bash

#remove
docker rm -f $(docker ps -qa)

#CREATE NETWORK
docker network create trio-task-network

#BUILD FLASK AND MYSQL
docker build -t trio-task-mysql:5.7 db
docker build -t trio-task-flask-app:latest flask-app

#RUN MYSQL CONTAINER
docker run -d \
    --name mysql \
    --network trio-task-network \
    trio-task-mysql:5.7


#RUN FLASK CONTAINER
docker run -d \
    --name flask-app \
    --network trio-task-network \
    -e MYSQL_ROOT_PASSWORD=cake \
    trio-task-flask-app:latest

#RUN NGINX 
docker run -d \
    --name nginx \
    -p 80:80 \
    --network trio-task-network \
    --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf \
    nginx:latest

#SHOW RUNNING CONTAINERS
echo
docker ps -a 