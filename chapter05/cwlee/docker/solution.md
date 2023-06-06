[공식문서](https://docs.docker.com/registry/spec/api/)

### 이미지 업로드 하기
```
☁  ch05 [main] ⚡  docker image push registry.local:5000/gallery/ui
```

</br>

### 대상 리포지터리(gallery/ui)의 태그 목록 확인하기
```
☁  ch05 [main] ⚡  curl -X GET http://registry.local:5000/v2/gallery/ui/tags/list
{"name":"gallery/ui","tags":["v1"]}
```

</br>

### 이미지 매니페스트 확인하기
`Docker-Content-Digest` Header를 확인한다.
```
☁  ch05 [main] ⚡  curl --head \
  http://registry.local:5000/v2/gallery/ui/manifests/v1 \    
  -H 'Accept: application/vnd.docker.distribution.manifest.v2+json'
HTTP/1.1 200 OK
Content-Length: 1574
Content-Type: application/vnd.docker.distribution.manifest.v2+json
...
```

</br>

### 이미지 삭제하기
```
☁  ch05 [main] ⚡  curl -X DELETE http://registry.local:5000/v2/gallery/ui/manifests/sha256:...
```

</br>

### 대상 리포지터리(gallery/ui)의 태그 목록 확인하기
```
☁  ch05 [main] ⚡  curl -X GET http://registry.local:5000/v2/gallery/ui/tags/list
{"name":"gallery/ui","tags":null}
```