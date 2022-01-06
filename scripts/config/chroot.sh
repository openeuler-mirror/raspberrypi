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
    echo "user-session=xfce" >> /etc/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf
    sed -i -e 's/^background=/#background=/' /etc/lightdm/lightdm-gtk-greeter.conf
    sed -i -e '/^#background=/cbackground=/usr/share/backgrounds/xfce/xfce-blue.jpg' /etc/lightdm/lightdm-gtk-greeter.conf
elif [ "x$1" == "xdde" ]; then
    if id openeuler; then
        userdel -r openeuler
    fi
fi
cd /etc/rc.d/init.d
chmod +x extend-root.sh
chkconfig --add extend-root.sh
chkconfig extend-root.sh on
cd -
ln -s /lib/firmware /etc/firmware
if [ "x$1" == "xxfce" ] || [ "x$1" == "xukui" ] || [ "x$1" == "xdde" ]; then
    if [ -f /etc/locale.conf ]; then
        sed -i -e "s/^LANG/#LANG/" /etc/locale.conf
    fi
    echo 'LANG="zh_CN.UTF-8"' >> /etc/locale.conf
fi
