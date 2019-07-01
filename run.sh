#!/bin/bash

docker stop ssh-cont
docker rm ssh-cont
docker stop cont
docker rm cont
docker rmi ssh-image
docker rmi custom-image

docker volume create my-vol

docker build  -t a-image ssh

docker build  -t b-image nossh

docker run -d \
	--name a-cont \
	--mount source=my-vol,target=/home/a \
	a-image

docker exec -it a-cont bash

docker stop a-cont
docker rm a-cont


docker stop b-cont
docker rm b-cont
docker run -d \
    --name b-cont \
    --mount type=volume,source=my-vol,target=/home/a \
    b-image

docker exec -it b-cont bash
