#!/bin/bash

docker run --name lab -d diamol/ch03-lab sh -c 'echo yckim >> ch03.txt'
docker commit lab zxcv9203/ch03-lab
