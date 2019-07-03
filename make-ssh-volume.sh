#!/bin/bash

docker volume rm ssh-vol
docker volume create ssh-vol

docker stop make-ssh-vol-cont
docker rm make-ssh-vol-cont

docker build -t make-ssh-vol-image make-ssh-vol
docker run -d -P \
    --name make-ssh-vol-cont \
    --mount type=volume,source=ssh-vol,target=/etc/ssh \
    make-ssh-vol-image
