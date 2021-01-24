<!-- TOC -->

- [环境需求](#环境需求)
- [树莓派相关](#树莓派相关)
    - [编译内核](#编译内核)
        - [准备环境](#准备环境)
        - [下载源码](#下载源码)
        - [进入内核目录](#进入内核目录)
        - [切换分支](#切换分支)
        - [载入默认配置](#载入默认配置)
        - [编译](#编译)
        - [创建编译内核模块目录](#创建编译内核模块目录)
        - [编译内核模块](#编译内核模块)
        - [收集编译结果](#收集编译结果)
    - [配置引导](#配置引导)
        - [下载引导](#下载引导)
        - [进入引导目录](#进入引导目录)
        - [删除没有必要的文件](#删除没有必要的文件)
        - [添加cmdline.txt](#添加cmdlinetxt)
        - [boot 内容完善](#boot-内容完善)
            - [将内核放进引导](#将内核放进引导)
            - [将设备树文件放进引导](#将设备树文件放进引导)
    - [树莓派固件和应用](#树莓派固件和应用)
        - [下载固件和应用](#下载固件和应用)
- [制作 openEuler 的 rootfs](#制作-openeuler-的-rootfs)
    - [创建 RPM 数据库](#创建-rpm-数据库)
    - [下载安装 openEuler 发布包](#下载安装-openeuler-发布包)
    - [安装 yum](#安装-yum)
        - [添加 yum 源](#添加-yum-源)
        - [安装 dnf](#安装-dnf)
        - [安装必要软件](#安装必要软件)
    - [添加配置文件](#添加配置文件)
        - [添加 hosts](#添加-hosts)
        - [网络相关](#网络相关)
    - [rootfs 内容完善](#rootfs-内容完善)
        - [将固件放进 rootfs](#将固件放进-rootfs)
        - [将内核模块放进rootfs](#将内核模块放进rootfs)
    - [rootfs设置](#rootfs设置)
- [制作镜像](#制作镜像)
    - [生成镜像并分区挂载](#生成镜像并分区挂载)
        - [计算镜像大小](#计算镜像大小)
        - [创建空镜像](#创建空镜像)
        - [使用 losetup 将磁盘镜像文件虚拟成块设备](#使用-losetup-将磁盘镜像文件虚拟成块设备)
        - [使用 kpartx 创建分区表 /dev/loop0 的设备映射](#使用-kpartx-创建分区表-devloop0-的设备映射)
        - [格式化分区](#格式化分区)
        - [创建要挂载的根目录和 boot 分区路径](#创建要挂载的根目录和-boot-分区路径)
        - [挂载根目录和 boot 分区](#挂载根目录和-boot-分区)
        - [获取生成的 img 镜像的 blkid](#获取生成的-img-镜像的-blkid)
    - [修改 fstab](#修改-fstab)
    - [rootfs 拷贝到镜像](#rootfs-拷贝到镜像)
    - [boot 引导拷贝到镜像](#boot-引导拷贝到镜像)
    - [卸载镜像](#卸载镜像)
        - [同步到盘](#同步到盘)
        - [卸载](#卸载)
        - [卸载镜像文件虚拟的块设备](#卸载镜像文件虚拟的块设备)

<!-- /TOC -->

>![](public_sys-resources/icon-note.gif) **说明：**   
>如需根据自身需求定制镜像，可参考本文档。

# 环境需求

- 操作系统：openEuler 或 Centos 7/8；
- 架构：AArch64；
- 硬盘存储不低于 50G；
- 内存不低于 2G；
- 可访问外网。

可以通过以下方式获取 AArch64 架构的运行环境：

- 使用 AArch64 架构的主机，例如树莓派
- 使用 [QEMU](https://www.qemu.org/) 模拟器搭建 AArch64 运行环境

# 树莓派相关

操作目录：${WORKDIR}

## 编译内核

### 准备环境

- 操作系统：openEuler 或 Centos 7/8
- 架构：AArch64

除了使用 AArch64 架构的 openEuler 或 Centos 7/8 运行环境，也可以采用交叉编译的方式编译内核，文档详见 [交叉编译内核](./交叉编译内核.md)。这里，我们在 AArch64 架构的服务器上编译内核。

### 下载源码

`git clone git@gitee.com:openeuler/raspberrypi-kernel.git`

得到文件 ${WORKDIR}/raspberrypi-kernel。

### 进入内核目录

`cd ${WORKDIR}/raspberrypi-kernel`

### 切换分支

这里适用于树莓派的内核源码的分支有 openEuler-20.03-LTS 和 openEuler-20.09，分别对应不同的内核版本。根据需要选择对应分支，下载源码后默认为 master 分支，如果需要选择 openEuler-20.03-LTS 分支，执行下面的命令：

`git checkout -b openEuler-20.03-LTS origin/openEuler-20.03-LTS`

下面编译时可能还需要 bison、flex、build-essential 等，根据提示安装即可。

### 载入默认配置

`make ARCH=arm64 openeuler-raspi_defconfig`

其中 openeuler-raspi_defconfig 在 ../linux/arch/arm64/configs 下。

### 编译

`make ARCH=arm64 -j4`

### 创建编译内核模块目录

`mkdir ${WORKDIR}/ouput`

### 编译内核模块

`make INSTALL_MOD_PATH=${WORKDIR}/output/ modules_install`

在 ${WORKDIR}/output 文件夹下会生成 lib 文件夹。

### 收集编译结果

1.  内核

    `cp ${WORKDIR}/raspberrypi-kernel/arch/arm64/boot/Image ${WORKDIR}/output/`

2.  设备树文件等

    `cp ${WORKDIR}/raspberrypi-kernel/arch/arm64/boot/dts/broadcom/*.dtb ${WORKDIR}/output/`

    `mkdir ${WORKDIR}/output/overlays`

    `cp ${WORKDIR}/raspberrypi-kernel/arch/arm64/boot/dts/overlays/*.dtb* ${WORKDIR}/output/overlays/`

至此，所有内核及内核模块相关内容都在 ${WORKDIR}/output 下了。

## 配置引导

### 下载引导

`cd ${WORKDIR}`

`git clone --depth=1 https://github.com/raspberrypi/firmware`

得到文件 ${WORKDIR}/firmware 。

### 进入引导目录

`cd ${WORKDIR}/firmware/boot`

### 删除没有必要的文件

`rm *.dtb cmdline.txt kernel.img kernel7.img`

### 添加cmdline.txt

`touch cmdline.txt`

写入新系统的内核参数：

`console=ttyAMA0,115200 console=tty1 root=/dev/mmcblk0p3 rootfstype=ext4 elevator=deadline rootwait`

### boot 内容完善

#### 将内核放进引导

`cp ${WORKDIR}/output/Image ${WORKDIR}/firmware/boot/kernel8.img`

#### 将设备树文件放进引导

`cp ${WORKDIR}/output/*.dtb ${WORKDIR}/firmware/boot/`

`cp ${WORKDIR}/output/overlays/* ${WORKDIR}/firmware/boot/overlays/`

## 树莓派固件和应用

### 下载固件和应用

1.  进入下载目录

    `cd ${WORKDIR}`

2.  下载 bluez-firmware

    `git clone --depth=1 https://github.com/RPi-Distro/bluez-firmware`

    得到文件 ${WORKDIR}/bluez-firmware。

3.  下载 firmware-nonfree

    `git clone --depth=1 https://github.com/RPi-Distro/firmware-nonfree`

    得到文件 ${WORKDIR}/firmware-nonfree。

4.  下载 pi-bluetooth

    `git clone https://github.com/RPi-Distro/pi-bluetooth`

    得到文件 ${WORKDIR}/pi-bluetooth。

# 制作 openEuler 的 rootfs

操作目录：${WORKDIR}

## 创建 RPM 数据库

`mkdir ${WORKDIR}/rootfs`

`mkdir -p ${WORKDIR}/rootfs/var/lib/rpm`

`rpm --root ${WORKDIR}/rootfs/ --initdb`

## 下载安装 openEuler 发布包

`rpm -ivh --nodeps --root ${WORKDIR}/rootfs/ http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/Packages/openEuler-release-20.03LTS-33.oe1.aarch64.rpm`

会在 ${WORKDIR}/rootfs 下生成三个文件夹:

etc/ usr/ var/

## 安装 yum

### 添加 yum 源

`mkdir ${WORKDIR}/rootfs/etc/yum.repos.d`

`curl -o ${WORKDIR}/rootfs/etc/yum.repos.d/openEuler-20.03-LTS.repo https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-20.03-LTS/generic.repo`

### 安装 dnf

`dnf --installroot=${WORKDIR}/rootfs/ install dnf --nogpgcheck -y`

### 安装必要软件

`dnf --installroot=${WORKDIR}/rootfs/ makecache`

`dnf --installroot=${WORKDIR}/rootfs/ install -y alsa-utils wpa_supplicant vim net-tools iproute iputils NetworkManager openssh-server passwd hostname ntp bluez pulseaudio-module-bluetooth`

## 添加配置文件

### 添加 hosts

`cp /etc/hosts ${WORKDIR}/rootfs/etc/hosts`

### 网络相关

1.  设置 DNS

    `cp -L /etc/resolv.conf ${WORKDIR}/rootfs/etc/resolv.conf`

    编辑添加 nameserver：

    `vim ${WORKDIR}/rootfs/etc/resolv.conf`

    内容：
    ```
    nameserver 8.8.8.8
    nameserver 114.114.114.114
    ```

2.  设置 IP 自动获取

    `mkdir ${WORKDIR}/rootfs/etc/sysconfig/network-scripts`

    `vim ${WORKDIR}/rootfs/etc/sysconfig/network-scripts/ifcfg-eth0`

    内容：
    ```
    TYPE=Ethernet
    PROXY_METHOD=none
    BROWSER_ONLY=no
    BOOTPROTO=dhcp
    DEFROUTE=yes
    IPV4_FAILURE_FATAL=no
    IPV6INIT=yes
    IPV6_AUTOCONF=yes
    IPV6_DEFROUTE=yes
    IPV6_FAILURE_FATAL=no
    IPV6_ADDR_GEN_MODE=stable-privacy
    NAME=eth0
    UUID=851a6f36-e65c-3a43-8f4a-78fd0fc09dc9
    ONBOOT=yes
    AUTOCONNECT_PRIORITY=-999
    DEVICE=eth0
    ```

## rootfs 内容完善

### 将固件放进 rootfs

```
mkdir -p ${WORKDIR}/rootfs/lib/firmware ${WORKDIR}/rootfs/usr/bin ${WORKDIR}/rootfs/lib/udev/rules.d ${WORKDIR}/rootfs/lib/systemd/system
cp ${WORKDIR}/bluez-firmware/broadcom/* ${WORKDIR}/rootfs/lib/firmware/`
cp -r ${WORKDIR}/firmware-nonfree/brcm/ ${WORKDIR}/rootfs/lib/firmware/
wget https://raw.githubusercontent.com/RPi-Distro/raspberrypi-sys-mods/master/etc.armhf/udev/rules.d/99-com.rules -P ${WORKDIR}/rootfs/lib/udev/rules.d/
cp pi-bluetooth/usr/bin/* ${WORKDIR}/rootfs/usr/bin/
cp pi-bluetooth/lib/udev/rules.d/90-pi-bluetooth.rules ${WORKDIR}/rootfs/lib/udev/rules.d/
cp pi-bluetooth/debian/pi-bluetooth.bthelper\@.service ${WORKDIR}/rootfs/lib/systemd/system/bthelper\@.service
cp pi-bluetooth/debian/pi-bluetooth.hciuart.service ${WORKDIR}/rootfs/lib/systemd/system/hciuart.service
```

蓝牙相关固件放到 ${WORKDIR}/rootfs/lib/firmware/brcm/ 下：

```
mv ${WORKDIR}/rootfs/lib/firmware/BCM43430A1.hcd ${WORKDIR}/rootfs/lib/firmware/brcm/`
mv ${WORKDIR}/rootfs/lib/firmware/BCM4345C0.hcd ${WORKDIR}/rootfs/lib/firmware/brcm/
```

### 将内核模块放进rootfs

`cp -r ${WORKDIR}/output/lib/modules ${WORKDIR}/rootfs/lib/`

## rootfs设置

1.  挂载必要的路径

    `mount --bind /dev ${WORKDIR}/rootfs/dev`

    `mount -t proc /proc ${WORKDIR}/rootfs/proc`

    `mount -t sysfs /sys ${WORKDIR}/rootfs/sys`

2.  run chroot

    `chroot ${WORKDIR}/rootfs /bin/bash`

3.  开机自启ssh

    `systemctl enable ssh`

4.  设置root密码
 
    `passwd root`

    输入要设置的root密码。

5.  设置主机名

    `echo openEuler > /etc/hostname`

6.  设置默认时区为东八区

    `ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime`

7.  开机自启 hciuart

    `systemctl enable hciuart`

8.  退出

    `exit`

9.  取消临时挂载的目录

    `umount -l ${WORKDIR}/rootfs/dev`

    `umount -l ${WORKDIR}/rootfs/proc`

    `umount -l ${WORKDIR}/rootfs/sys`

# 制作镜像

## 生成镜像并分区挂载

### 计算镜像大小

`du -sh --block-size=1MiB ${WORKDIR}/rootfs`
`du -sh --block-size=1MiB ${WORKDIR}/firmware/boot`

得到总大小略加 1100MiB 即可，将该大小记为 `SIZE`。

### 创建空镜像

`cd ${WORKDIR}`

`dd if=/dev/zero of=openEuler_raspi.img bs=1M count=SIZE`

其中 `SIZE` 为前面计算得到的计算镜像大小，最终生成空的镜像文件 ${WORKDIR}/openEuler_raspi.img。

### 使用 losetup 将磁盘镜像文件虚拟成块设备

`losetup -f --show openEuler_raspi.img`

例如，显示结果为 /dev/loop0。

### 使用 kpartx 创建分区表 /dev/loop0 的设备映射

`kpartx -va /dev/loop0`

得到结果将 /dev/loop0 三个分区挂载了:
```
add map loop0p1 ...
add map loop0p2 ...
add map loop0p3 ...
```

运行 `ls /dev/mapper/loop0p*` 可以看到分区分别对应刚才为 openEuler_raspi.img 做的三个分区：

```
/dev/mapper/loop0p1 /dev/mapper/loop0p2 /dev/mapper/loop0p3
```

### 格式化分区

1.  格式化 boot 分区

    `mkfs.vfat -n boot /dev/mapper/loop0p1`

2.  格式化交换分区

    `mkswap /dev/mapper/loop0p2 --pagesize 4096`

3.  格式化根目录分区

    `mkfs.ext4 /dev/mapper/loop0p3`

### 创建要挂载的根目录和 boot 分区路径

`mkdir ${WORKDIR}/root ${WORKDIR}/boot`

### 挂载根目录和 boot 分区

`mount -t vfat -o uid=root,gid=root,umask=0000 /dev/mapper/loop0p1 ${WORKDIR}/boot/`

`mount -t ext4 /dev/mapper/loop0p3 ${WORKDIR}/root/`

### 获取生成的 img 镜像的 blkid

执行命令 blkid 得到三个分区的 UUID，例如：
```
/dev/mapper/loop0p1: SEC_TYPE="msdos" LABEL="boot" UUID="2785-C7C3" TYPE="vfat" PARTUUID="e0a091bd-01"
/dev/mapper/loop0p2: UUID="a451bee4-4384-48a2-8d5a-d09c2dd9a1a2" TYPE="swap" PARTUUID="e0a091bd-02"
/dev/mapper/loop0p3: UUID="67b5fc1c-9cd3-4884-968c-4ca35e5ae154" TYPE="ext4" PARTUUID="e0a091bd-03"
```

## 修改 fstab

`vim ${WORKDIR}/rootfs/etc/fstab`

内容：
```
UUID=67b5fc1c-9cd3-4884-968c-4ca35e5ae154  / ext4    defaults,noatime 0 0
UUID=2785-C7C3  /boot vfat    defaults,noatime 0 0
UUID=a451bee4-4384-48a2-8d5a-d09c2dd9a1a  swap swap    defaults,noatime 0 0
```

## rootfs 拷贝到镜像

`rsync -avHAXq ${WORKDIR}/rootfs/* ${WORKDIR}/root`

## boot 引导拷贝到镜像

`cd ${WORKDIR}/firmware/boot`

`tar cf ${WORKDIR}/boot.tar ./`

`cd ${WORKDIR}/boot`

`tar xf ${WORKDIR}/boot.tar -C .`

## 卸载镜像

### 同步到盘

`sync`

### 卸载

`umount ${WORKDIR}/root`

`umount ${WORKDIR}/boot`

### 卸载镜像文件虚拟的块设备

`kpartx -d /dev/loop0`

`losetup -d /dev/loop0`

这样，最终就生成了需要的 openEuler_raspi.img 镜像文件。

之后就可以使用镜像刷写 SD 卡并使用树莓派了，详见 [刷写镜像](./刷写镜像.md) 和 [树莓派使用](./树莓派使用.md)。
