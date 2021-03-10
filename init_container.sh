#!/usr/bin/env bash


docker-compose build --no-cache
docker-compose run web rails db:migrate