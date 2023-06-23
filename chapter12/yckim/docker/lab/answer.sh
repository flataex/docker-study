docker network create --driver overlay numbers

docker service create -d --network numbers --name numbers-api diamol/ch08-numbers-api:v3

docker service create -d --network numbers --name numbers-web -p 8020:80  diamol/ch08-numbers-web:v3