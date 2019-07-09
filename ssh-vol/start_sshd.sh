#!/bin/bash

groupadd sshd
useradd -g sshd -d / sshd
/ets/ssh/ssh_setup.sh
/etc/ssh/openssh/sbin/sshd
