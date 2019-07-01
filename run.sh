#!/bin/bash

docker volume create ssh-vol

docker build -t ssh-cont ssh

docker build -t custom-image nossh

docker run -d \
	--name ssh-cont \
	--mount source=ssh,target=/etc/ssh \
	ssh-cont

docker stop ssh-cont
docker rm ssh-cont

docker run -d \
    --name cont \
    --mount source=ssh,/target/etc/ssh \
    custom-image

