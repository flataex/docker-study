#!/bin/bash

docker-compose -f docker-compose.yml -f docker-compose-dev.yml -p todo-dev up -d
docker-compose -f docker-compose.yml -f docker-compose-test.yml -p todo-test up -d
