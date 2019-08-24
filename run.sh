#!/bin/bash

docker stop a-cont
docker rm a-cont

docker build  -t a-image nossh
docker run -d -P \
    -p 0.0.0.0:32823:2222 \
    --name a-cont \
    --mount type=volume,source=ssh-vol,target=/etc/ssh \
    a-image

docker exec -it a-cont /etc/ssh/start_sshd.sh
rm /root/.ssh/known_hosts
ssh -p 32823 localhost

