# 도커 컴포즈로 분산 애플리케이션 실행하기

- 도커는 n-티어 모놀리식 설계부터 현대적인 마이크로서비스 설계까지 분산된 컴포넌트를 실행하는 데 이상적인 환경입니다.

## 도커 컴포즈 파일의 구조

- Front-end, Back-end API, DB를 갖춘 애플리케이션을 패키징하려면 각 컴포넌트에 하나씩 세 개의 Dockerfile 스크립트가 필요하며, 이것을 각각 실행하는 것은 편의성에서도 불리하고 실수를 유발합니다. 이것을 YAML 문법으로 기술된 도커 컴포즈 파일에 애플리케이션 구조를 정의하면 됩니다.

- 도커 컴포즈 파일 구성
  - version : 도커 컴포즈 파일 형식의 버전
  - services : 애플리케이션을 구성하는 모든 컴포넌트를 열거(하나의 이미지로 여러개의 컨테이너 실행가능)
  - network : 서비스 컨테이너가 연결될 모든 도커 네트워크를 열거

```shell
docker network create nat
cd ./ch07/exercises/todo-list && docker-compose up
```

- nat 네트워크를 생성하고 예제 도커 컴포즈 파일을 실행합니다.
- 도커 컴포즈 파일은 애플리케이션의 소스 코드. Dockerfile 스크립트와 함께 형상 관리 도구로 관리되며 모든 실행 옵션이 기술되어서 README 파일에 애플리케이션 이미지 이름이나 공개해야 할 포트 번호를 문서화할 필요가 없어집니다.

## 도커 컴포즈를사용해 여러 컨테이너로 구성된 애플리케이션 실행하기

- 도커 컴포즈 스크립트를 다이어그램으로 변환해주시는 도구입니다.(`https://github.com/pmsipilot/docker-compose-viz`)

```shell
cd ./chQ7/exercises/image-of-the-day
docker-compose up -d
```

- 도커 컴포즈를 사용해 detached mode로 애플리케이션을 실행합니다.
- detach(-d)를 사용할 경우 컨테이너가 백그라운드에서 실행되므로 실행한 창에 로그가 출력되지 않습니다.
- `WARN[0000] network app-net: network.external.name is deprecated. Please set network.name with external: true`가 출력되는데 `networks.app-net.external: true` 로 수정하면 해결됩니다.
- `docker-compose` 입력시 전체 부명령을 확인할 수 있습니다.
- `docker-compose stop` 컨테이너를 중지 시킬 수 있습니다.
- `docker-compose down` 컨테이너를 삭제할 수 있습니다.

## 도커 컨테이너 간의 통신

- 애플리케이션 생애주기 동안에 컨테이너가 교체되면 IP 주소도 변경되지만 IP 주소가 변경돼도 문제가 없도록 도커에서 DNS를 이용해 서비스 디스커버리 기능을 제공합니다. 도커에도 DNS 서비스가 내장되어 컨테이너 이름을 도메인 삼아 IP를 조회하고 도메인이 가리키는 대상이 컨테이너가 아니라면 호스트 컴퓨터가 속한 네트워크나 인터넷의 IP 주소를 조회합니다.

- `docker container exec -it image-of-the-day-image-gallery-1 sh -c "nslookup accesslog"`를 통해서 `image-of-the-day-image-gallery-1` 컨테이너에 접속해 `accesslog`가 어떤 ip로 통신하는지 알 수 있습니다.

## 도커 컴포즈로 애플리케이션 설정값지정하기

- 환경 변수나 바인드 마운 트 설정, 비밀값 등으로 설정값이 적용할 수 있습니다.

## 도커 컴포즈도 만능은 아니다

- 도커 컴포즈는 도커 스웜이나 쿠버네티스 같은 완전한 컨테이너 플랫폼이 아닙니다.
- 고가용성, 로드 밸런싱, 이중화 같은 기능은 없습니다.
