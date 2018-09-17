#!/bin/bash

./config/init/10-init-set-root-pass.sh;
mkdir -p ~/.ssh;
cat /etc/ssh/id_rsa.pub > ~/.ssh/authorized_keys;
chmod 600 ~/.ssh/authorized_key;
/usr/sbin/sshd -D;
