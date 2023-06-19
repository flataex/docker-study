```shell
docker network create --driver overlay numbers-net

docker service create -d --replicas 2 --network numbers-net --name numbers-api diamol/ch08-numbers-api:v3

docker service create -dp 8099:80 --replicas 2 --network numbers-net --name numbers-web diamol/ch08-numbers-web:v3
```
