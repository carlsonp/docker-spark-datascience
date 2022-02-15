#!/bin/bash
export DOCKER_BUILDKIT=1
docker system prune -f
docker stack rm spark
docker compose build --parallel --pull
docker compose push
docker stack deploy --compose-file docker-compose.yml spark
