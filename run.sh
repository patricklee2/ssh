#!/bin/bash

docker stop a-cont
docker rm a-cont

docker build  -t a-image nossh
docker stop a-cont
docker rm a-cont
docker run -d -P \
    --name b-cont \
    --mount type=volume,source=my-vol,target=/etc/ssh \
    b-image

docker exec -it b-cont /etc/ssh/start_sshd.sh
