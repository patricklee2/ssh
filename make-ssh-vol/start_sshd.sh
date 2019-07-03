#!/bin/bash

groupadd sshd; && useradd -g sshd -d / sshd; &&/etc/ssh/sbin/sshd
