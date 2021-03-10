#!/usr/bin/env bash
docker network create shared-network
docker-compose  run web rails  db:create db:migrate
docker-compose up -d
sleep 1
