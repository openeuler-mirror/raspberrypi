#!/bin/bash
set -e
systemctl enable sshd
systemctl enable ntpd
echo openEuler > /etc/hostname
echo "openeuler" | passwd --stdin root
if [ -f /usr/share/zoneinfo/Asia/Shanghai ]; then
    if [ -f /etc/localtime ]; then
        rm -f /etc/localtime
    fi
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
fi

