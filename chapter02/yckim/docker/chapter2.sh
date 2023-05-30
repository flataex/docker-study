#!/bin/bash

TARGET="/usr/local/apache2/htdocs/index.html"
MESSAGE="hello, world"
docker container run -d -p 8080:80 --name docker-textbook-web diamol/ch02-hello-diamol-web

docker container exec -it docker-textbook-web sh -c "echo $MESSAGE > $TARGET"

RESULT=$(curl localhost:8080)

if [ "$MESSAGE" == "$RESULT" ]; then
  echo "✅✅✅ 테스트 성공 ✅✅✅"
else
  echo "🚨🚨🚨 테스트 실패 🚨🚨🚨"
fi

docker container stop docker-textbook-web
docker container rm docker-textbook-web