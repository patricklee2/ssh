#!/bin/bash

apt-get upgrade -y openssl 
groupadd sshd
useradd -g sshd -d / sshd
/etc/ssh/sbin/sshd
