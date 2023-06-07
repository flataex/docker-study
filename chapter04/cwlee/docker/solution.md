```
- Dockerfile 스크립트로 이미지를 빌드한다. 이어서 Dockerfile 스크립트를 최적화한 다음 새로운 이미지를 빌드한다.
- 최적화된 이미지의 크기가 리눅스 환경에서 약 15MB. 윈도 환경에서 약 260MB가 되도록 한다.
- Dockerfile 스크립트를 최적화해 HTML 파일을 수정하더라도 재수행하는 빌드 단계가 한 단계가 되도록 한다.
```

📌 경량화 이전 Dockefile을 빌드한다.
```
$ docker build -t lab-04 -f ./Dockerfile .
```

📌 경량화한 Dockerfile.optimized 파일
```
FROM diamol/golang AS builder

COPY main.go .
RUN go build -o /web/server

FROM diamol/base

ENV USER=sixeyed
EXPOSE 80
CMD ["/web/server"]

WORKDIR web
COPY --from=builder /web/server /web

RUN chmod +x /web/server
COPY index.html .
```
```
1. multi-stage build를 활용해 빌드 도구와 라이브러리 등의 빌드 시에만 필요한 파일들을 최종 이미지에서 제거한다.
2. 변경될 가능성이 더 적은 명령을 먼저 실행한다. WORKDIR, ENV, EXPOSE 같은 명령을 RUN, COPY 명령보다 먼저 위치시킨다.
3. index.html를 마지막에 두어 HTML 변경 시 재수행되는 빌드 단계가 한 단계가 되도록 한다.
```

📌 경량화한 Dockerfile.optimized을 빌드한다.
```
$ docker build -t lab-04-optimized -f ./Dockerfile.optimized .
```

📌 컨테이너를 실행한다.
```
$ docker container run -p 805:80 -d lab-04-optimized:latest
```

✅ 1차 빌드 결과

<img src="../img/8.png" width="55%" height="55%"/>

<img src="../img/9.png" width="85%" height="85%"/>

✅ 2차 빌드 결과 (→ index.html 파일 변경 후)

- 재수행하는 빌드 단계가 한 단계이다.
- 나머지는 캐시를 사용한다.

<img src="../img/10.png" width="55%" height="55%"/>

<img src="../img/11.png" width="85%" height="85%"/>

</br>

✅ 이미지 크기 비교

```
$ docker images ls -f reference=lab-04 -f reference=lab-04-optimized
```
<img src="../img/12.png" width="55%" height="55%"/>

📌 개선할 부분

- chmod + x /web/server도 builder stage에서 실행시킴으로써 최종 이미지의 크기를 줄일 수 있다.

```docker
FROM diamol/golang AS builder

COPY main.go .
RUN go build -o /web/server
RUN chmod +x /web/server

FROM diamol/base

ENV USER=sixeyed
EXPOSE 80
CMD ["/web/server"]

WORKDIR web
COPY --from=builder /web/server /web
COPY index.html .
```

<img src="../img/13.png" width="55%" height="55%"/>