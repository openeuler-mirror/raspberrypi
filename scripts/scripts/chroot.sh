#!/bin/bash
set -e
systemctl enable sshd
systemctl enable ntpd
hostname OpenEuler
echo "openeuler" | passwd --stdin root
