#!/bin/bash

docker stop ssh-cont
docker rm ssh-cont
docker stop cont
docker rm cont
docker rmi ssh-image
docker rmi custom-image

docker volume create ssh-vol

docker build --no-cache -t ssh-image ssh

docker build --no-cache -t custom-image nossh

docker run -d \
	--name ssh-cont \
	--mount source=ssh,target=/etc/ssh \
	ssh-image

docker stop ssh-cont
docker rm ssh-cont

docker run -d \
    --name cont \
    --mount source=ssh,target=/etc/ssh \
    custom-image

