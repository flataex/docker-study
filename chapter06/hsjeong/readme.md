# 도커 볼륨을 이용한 퍼시스턴트 스토리지

## 컨테이너 속 데이터가 사라지는 이유

- 같은 이미지에서 실행한 여러 개의 컨테이너는 처 음에는 디스크의 내용이 모두 같지만. 그중 한 컨테이너에서 애플리케이션이 파일을 수정해도 다 른 컨테이너나 이미지는 영향을 받지 않습니다.

```shell
docker run --name rn1 diamol/ch06-random-number
docker run --name rn2 diamol/ch06-random-number
```

```shell
docker cp rn1:/random/number.txt number1.txt
docker cp rn2:/random/number.txt number2.txt
cat number1.txt && cat number2.txt
```

- random 숫자를 출력하는 컨테이너를 두개 실행하면 각각 다른 값이 출력됩니다. 이는 파일 시스템이 서로 독립적임을 알 수 있습니다.
- 이미지 레이어는 모든 컨테이너가 공유하지만 기록 가능 레이어는 컨테이너마다 다릅니다.
- 기록 중 복사라는 방법을 사용해 읽기 전용 레이어의 파 일을 수정할 수 있습니다.
  - 도커가 이 파일을 쓰기 가능 레이어로 복사해 온 다음 쓰기 가능 레이어에서 파일을 수정

```shell
docker run --name f1 diamol/ch06-file-display
echo “http://eltonstoneman.com” > url.txt
docker cp url.txt f1:/input.txt
docker start --attach f1
```

- 처음 실행했을때와 로컬 파일을 복사했을때는 결과가 달라집니다.
- 컨테이너 속 파일을 수정하면 컨테이너의 동작에 영향을 미치지만 이미지를 공유하는 다른 컨테이너나 이미지는 영향을 받지 않습니다.

```shell
docker run --name f2 diamol/ch06-file-display
docker rm -f f1
docker cp f1:input.txt .
```

- fl 컨테이너가삭제되면 수정된 파일도 사라집니다.
- 만약 데이터베이스를 도커 컨테이너로 띄운다면 업데이트시 데이터가 모두 사라질것입니다. 이렇기에 도커볼륨과 마운트가 있습니다.

## 도커 볼륨을 사용하는 컨테이너 실행하기

- 컨테이너에서 볼륨을 사용하는 방법
  - 수동으로 직접 볼륨을 생성해 컨테이너에 연결하는 방법
  - Dockerfile 스크립트에서 VOLUME 인스트럭션을 사용하는 방법

```shell
docker run --name todo1 -dp 8010:80 diamol/ch06-todo-list
docker inspect -f '{{.Mounts}}' todo1
docker volume ls
```

- todo 예제를 실행하고 볼륨에 마운트된것을 확인할 수 있습니다.
- volumes-from 플래그를 적용하면 다른 컨테이너의 볼륨을 연결할 수 있습니다.

```shell
docker run --name todo2 -d diamol/ch06-todo-list
docker exec todo2 ls /data
docker run  -d --name t3 --volumes-from todo1 diamol/ch06-todo-list
docker exec t3 ls /data
```

- todo2는 새로운 볼륨을 연결하기 떄문에 비어있지만 t3의 경우 todo1과 연결하여 추가된 데이터가 보입니다.
- 볼륨은 업데이트 간 상태를 보존하기 위한 용도로 사용하는게 좋습니다.

```shell
target='/data'
docker volume create todo-list
docker run -dp 8011:80 -v todo-list:$target --name todo-v1 diamol/ch06-todo-list
docker rm -f todo-v1
docker run -dp 8011:80 -v todo-list:$target --name todo-v2 diamol/ch06-todo-list
```

- 륨은 컨테이너보다 먼저 생성돼 자신과 연결됐던 컨테이너 가 삭제된 뒤에도 그대로 남아있습니다.
- Dockerfile 스크립트의 VOLUME 인스트럭션과 docker container 명령의 一 volume 플래그는 별개 기능입니다. VOLUME 인스트럭션을 사용해 빌드된 이미지로 docker container run 명령에서 볼륨을 지정하지 않으면 항상 새로운 볼륨을 함께 생성합니다. 이 볼륨은 무작위로 만들어진 식별자를 가지므로. 컨테이너를 삭제한 후 볼륨을 재사용하려면 이 식별자를 미리 기억해야 합니다.
- volume 플래그는 이미지에 볼륨이 정의돼 있든 말든 지정된 볼륨을 컨테이너에 마운트합니다.

## 파일 시스템 마운트를 사용하는 컨테이너 실행하기

- 바인드 마운트 : 호스트 컴퓨터 파일 시스템의 디렉터리 를 컨테이너 파일 시스템의 디렉터리로 만들수 있습니다.

```shell
source="$(pwd)/databases" && target='/data'
mkdir ./databases
docker run --mount type=bind,source=$source,target=$target -dp 8012:80 diamol/ch06-todo-list
curl http://localhost:8012
ls ./databases
```

- 바인드 마운트는 양방향으로 동작합니다.
- 바인드 마운트를 사용하면 호스트 컴퓨터 파일에 접근하기 위해 권한 상승이 필요합니다.(USER 인스트럭션 사용)

```shell
source="$(pwd)/config" && target='/app/config'
docker run --name todo-configured -dp 8013:80 --mount type=bind,source=$source,target=$target,readonly  diamol/ch06-todo-list
curl http://localhost:8013
docker container logs todo-configured
```

- 로컬에 마운트하여 config를 변경하여 log를 debug로 출력합니다.

## 파일 시스템 마운트의 한계점

```shell
source="$(pwd)/new" && target='/init'
docker run diamol/ch06-bind-mount
docker run --mount type=bind,source=$source,target=$target diamol/ch06-bind-mount
```

- 이미 존재하는 대상 디렉터리에 마운트하면 마운트의 원본 디렉터리가 기존 디렉터리를 완전히 대체합니다.

```shell
docker container run --mount type=bind,source="$(pwd)/new/123.txt",target=/init/123.txt diamol/ch06-bind-mount
docker container run diamol/ch06-bind-mount
```

- 호스트 컴퓨터의 파일 하나를 컨테이너에 이미 존재하는 디렉터리로 마운트하면 디렉터리의 파일이 합쳐져 이미지에서 온 파일과 호스트에서 마운트된 파일이 모두 나타납니다.
- 분산 파일 시스템을 컨테이너에 바인드 마운트했을 때 로컬 컴퓨터 운영체제의 파일 시스템과 다른 경우가 많고 지원하지 않는 동작이 있을 수 있습니다.

## 컨테이너의 파일 시스템은 어떻게 만들어지는가?

- 유니언 파일 시스템 : 다양한 출처로부터 모아 만든 단일 가상 디스크로 구성된 파일 시스템
- 사용자는 여러 출처를 합쳐 이 디스크를 구성할 수 있습니다. 여러 개의 이미지 레이어, 역시 하나 이상의 볼륨 마운트와 바인드 마운트를 컨테이너에 연결할 수 있습니다.
- 기록 가능 레이어 : 비용이비싼계산이나네트워크를통해저장해야하는데이터의캐싱등 단기 저장에 적합, 컨테이너가 삭제되면 저장된 데이터는 유실
- 로컬 바인드 마운트 : 호스트 컴퓨터와 컨테이너 간 데이터를 공유하기 위해 사용, 로컬 컴퓨터에서 수 정한 내용이 이미지 빌드 없이도 즉시 컨테이너로 전달할 수 있음
- 분산 바인드 마운트 : 네트워크 스토리지와 컨테이너 간에 데이터를 공유하기 위해 사용, 읽기 전용으로 설정 파일을 전달하거나 공유캐시로 활용
- 볼륨 마운트 : 컨테이너와 도커 객체인 볼륨 간에 데이터를 공유하기 위해 사용, 볼륨에 데이터를 영구적으로 저장
- 이미지 레이어 : 컨테이너의 초기 파일 시스템을 구성, 후속 레이어와 이전 레이어의 내용이 서로 충돌하는 경우 후속 레이어의 내용이 적용, 읽기 전용
