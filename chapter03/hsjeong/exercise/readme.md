1. 도커 컨테이너를 실행하여 -it 옵션을 통해 접속합니다.

```shell
docker run -it --name test03 diamol/ch03-lab
```

2. echo 명령어를 통해 이름을 추가합니다. exit 로 나옵니다.

```shell
echo Hyoseong >> ch03.txt
```

3. 도커 커밋 명령어를 통해 수정내용을 반영합니다.

```shell
docker commit test03 test03-image
```

4. 도커 컨테이너를 실행하고 cat 명령어로 내용을 출력합니다.

```shell
docker run test03-image cat ch03.txt
```
