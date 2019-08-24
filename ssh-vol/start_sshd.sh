#!/bin/bash

groupadd sshd
useradd -g sshd -d / sshd
/etc/ssh/ssh_setup.sh
/etc/ssh/openssh/sbin/sshd 0f /etc/ssh/sshd_config
