#!/bin/bash
SOURCE=$(pwd)/databases
TARGET='/data'

rm -rf "$SOURCE"
mkdir -p "$SOURCE"
docker container run --mount type=bind,source="$SOURCE",target=$TARGET -d -p 8013:80 diamol/ch06-todo-list

