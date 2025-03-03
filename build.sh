#!/bin/bash

git pull origin master &&
docker compose -f docker-compose.yml build &&
docker compose -f docker-compose.yml push &&
docker stack deploy -c docker-compose.yml abc_database