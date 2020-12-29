#!/bin/bash
systemctl enable sshd
systemctl enable systemd-timesyncd
systemctl enable hciuart
systemctl enable haveged
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
if [ "x$1" == "xxfce" ]; then
    if [ -f /etc/lightdm/lightdm.conf ]; then
        sed -i 's/#user-session=default/user-session=xfce/g' /etc/lightdm/lightdm.conf
    fi
    if [ -d /etc/X11/xorg.conf.d ]; then
        echo -e "Section \"Device\"\n\tIdentifier \"fb gfx\"\n\tDriver \"fbdev\"\n\tOption \"fb\" \"/dev/fb0\"\nEndSection" > /etc/X11/xorg.conf.d/20-fbdev.conf
    fi
elif [ "x$1" == "xdde" ]; then
    if id openeuler; then
        userdel -r openeuler
    fi
fi