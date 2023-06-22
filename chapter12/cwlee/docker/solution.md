### create network
☁  ~  docker network create --driver overlay numbers
tax7uc32uonuwkszla0ejao31

### create service
☁  ~  docker service create --detach --replicas 3 --network numbers --name numbers-api diamol/ch08-numbers-api:v3
f9xrdgfzr1ko8naw5nve25ee3

☁  ~  docker service create --detach --replicas 2 --network numbers --publish 8020:80 --name numbers-web diamol/ch08-numbers-web:v3
lv4mdtb6rt8w48d9z4tjryq07

### result
☁  ~  docker service ls
ID             NAME            MODE         REPLICAS   IMAGE                                 PORTS
f9xrdgfzr1ko   numbers-api     replicated   3/3        diamol/ch08-numbers-api:v3
lv4mdtb6rt8w   numbers-web     replicated   2/2        diamol/ch08-numbers-web:v3           *:8020->80/tcp