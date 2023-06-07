```shell
docker run --name excercise -dp 8015:80 diamol/ch06-lab
```

- todo list 이미시 실행

```shell
docker volume create todo-excercise
```

- 볼륨 생성

```shell
configSource="$(pwd)/solution"
configTarget='/app/config'
dataTarget='/new-data'
```

- 경로를 변수로 만듭니다.

```shell
docker container run -dp 8016:80 --mount type=bind,source=$configSource,target=$configTarget,readonly --volume todo-excercise:$dataTarget diamol/ch06-lab
```

- config 파일을 변경하여 todo list가 빈 값으로 보입니다.
