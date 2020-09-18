#!/bin/bash
systemctl enable sshd
systemctl enable systemd-timesyncd
systemctl enable hciuart
echo openEuler > /etc/hostname
echo "openeuler" | passwd --stdin root
useradd -m -G "wheel" -s "/bin/bash" pi
echo "raspberry" | passwd --stdin pi
if [ -f /usr/share/zoneinfo/Asia/Shanghai ]; then
    if [ -f /etc/localtime ]; then
        rm -f /etc/localtime
    fi
    ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
fi
if [ -f /etc/rc.d/rc.local ]; then
    chmod +x /etc/rc.d/rc.local
fi
if [ -f /etc/lightdm/lightdm.conf ]; then
    sudo sed -i 's/#user-session=default/user-session=xfce/g' /etc/lightdm/lightdm.conf
fi
