```
docker-compose -f fluentd/docker-compose.yml -f fluentd/solution.yml up -d
docker-compose -f numbers/docker-compose.yml -f numbers/solution.yml up -d
```

http://localhost:8090 에서 난수 생성

http://localhost:5601 키바나에서 확인
