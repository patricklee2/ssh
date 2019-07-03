#!/bin/bash

docker stop ssh-cont
docker rm ssh-cont
docker stop cont
docker rm cont
docker rmi ssh-image
docker rmi custom-image

docker volume create my-vol

docker build  -t a-image ssh

docker run -d \
	--name a-cont \
	--mount source=my-vol,target=/etc/ssh \
	a-image

# docker exec -it a-cont bash

docker stop a-cont
docker rm a-cont

docker build  -t b-image nossh
docker stop b-cont
docker rm b-cont
docker run -d -P \
    --name b-cont \
    --mount type=volume,source=my-vol,target=/etc/ssh \
    b-image

docker exec -it b-cont bash


#apt-get install -y openssh-server
apt-get update -y
apt-get upgrade -y openssl
cd /etc/ssh
wget -c https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.0p1.tar.gz
tar -xzf openssh-8.0p1.tar.gz
cd openssh-8.0p1/
./configure --prefix=/etc/ssh --sysconfdir=/etc/ssh --with-pid-dir=/etc/ssh
make
make install 
cd ..

mkdir -p /var/run/sshd
/etc/ssh/sshd
