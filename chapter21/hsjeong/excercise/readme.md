```
docker-compose up -d
```

수신 대기 여부 확인

```
docker logs exercise-save-handler-1
docker logs excercise-audit-handler-1
docker logs excercise-mutating-handler-1
```

http://localhost:8081/new 에서 새 할일 추가
