```
echo \$'\n127.0.0.1 pi.local' | sudo tee -a /etc/hosts
docker-compose up -d
docker-compose -f nginx/docker-compose.yml -f nginx/override-linux.yml up -d
```

http://pi.local?dp=50000
