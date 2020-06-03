#!/bin/bash
docker system prune -f
docker stack rm spark
docker-compose build
docker-compose push
docker stack deploy --compose-file docker-compose.yml spark
