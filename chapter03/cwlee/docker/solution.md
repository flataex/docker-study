
```
Dockerfile 스크립트 없이 도커 이미지를 만든다.
1. 도커 허브에 공유된 diamol/ch03-lab 이미지를 사용한다.
2. /diamol/ch03.txt 파일 뒤에 이름을 추가한다.
3. 수정된 파일을 포함하는 새로운 이미지를 빌드한다.
```

1. docker image pull diamol/ch03-lab

2. docker container run -it --name ch03-lab diamol/ch03-lab
/diamol # ls
ch03.txt
/diamol # echo "chaewon" >> ch03.txt
/diamol # cat ch03.txt
Lab solution, by: chaewon
/diamol # exit

3. docker container commit ch03-lab ch03-lab-cwlee

4. docker container run ch03-lab-cwlee cat /diamol/ch03.txt
Lab solution, by: chaewon

