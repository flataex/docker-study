# A

1. 예시로 제공된 이미지를 실행

```shell
docker run -it --detach --publish 8088:80 diamol/ch02-hello-diamol-web
```

2. index.html 찾기

```shell
docker exec -it f487e802d532 ls /usr/local/apache2/htdocs
```

3. 로컬에 index.html을 실행시킨 컨테이너로 복사

```shell
docker container cp /Users/jeonghyoseong/workplace/docker-study/chapter01/hsjeong/exercise/index.html f487e802d532:/usr/local/apache2/htdocs/index.html
```

# B

1. 예시로 제공된 이미지를 실행

```shell
docker run -it --detach --publish 8088:80 diamol/ch02-hello-diamol-web
```

2. 컨테이너 접속

```shell
docker exec -it 0761868e7f5c /bin/sh
```

3. html파일 위치로 이동하여 vi 편집기 사용하여 수정

```shell
cd /usr/local/apache2/htdocs
vi index.html
```
