```
docker stack deploy -c image-gallery.yml image-gallery
docker stack ps image-gallery
```

- image-gallery stack을 생성합니다.

```
docker service inspect --pretty image-gallery_iotd
docker service ps image-gallery_iotd
```

- image-gallery_iotd을 확인합니다.

```
docker-compose -f image-gallery.yml -f v2.yml config > stack.yml
docker stack deploy -c stack.yml image-gallery
docker service ps image-gallery_iotd
```

- image-gallery를 update합니다.
