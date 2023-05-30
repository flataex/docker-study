
```
Dockerfile 스크립트 없이 도커 이미지를 만든다.
1. 도커 허브에 공유된 diamol/ch03-lab 이미지를 사용한다.
2. /diamol/ch03.txt 파일 뒤에 이름을 추가한다.
3. 수정된 파일을 포함하는 새로운 이미지를 빌드한다.
```

```
1. diamol/ch03-lab 이미지를 저장한다.
  $ docker image pull diamol/ch03-lab
```

```
2. diamol/ch03-lab 이미지를 컨테이너로 실행시킨다.
  $ docker container run -it --name ch03-lab diamol/ch03-lab
  /diamol # ls
  ch03.txt
  /diamol # echo "chaewon" >> ch03.txt
  /diamol # cat ch03.txt
  Lab solution, by: chaewon
  /diamol # exit
```

```
3. commit 명령어를 이용해 수정한 사항을 반영한 새로운 도커 이미지를 만드는 작업을 수행한다.
  $ docker container commit ch03-lab ch03-lab-cwlee
```

```
4. 새로 생성한 도커 이미지(ch03-lab-cwlee)를 실행한다.
  $ docker container run ch03-lab-cwlee cat /diamol/ch03.txt
  Lab solution, by: chaewon
```
