## Feature Release Log

[English](./changelog.en.md) | 简体中文

### 2020-05-09

#### 基本信息

- 发布时间：2020-05-11
- 大小：245 MiB
- 操作系统版本：openEuler 20.03 LTS
- 内核版本：4.19.90-2003.4.0.0036
- 固件来源：[firmware](https://github.com/raspberrypi/firmware)、[bluez-firmware](https://github.com/RPi-Distro/bluez-firmware)、[firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
- 构建文件系统的源仓库：[openEuler-20.03-LTS](http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
- 镜像内置源仓库：[openEuler 20.03 LTS 源仓库](https://gitee.com/openeuler/raspberrypi/blob/master/config/openEuler-20.03-LTS.repo)

#### 更新说明

##### 蓝牙

默认启动蓝牙相关服务，并绑定蓝牙设备。

### 2020-04-27

#### 基本信息

- 发布时间：2020-04-27
- 大小：240 MiB
- 操作系统版本：openEuler 20.03 LTS
- 内核版本：4.19.90-2003.4.0.0036
- 固件来源：[firmware](https://github.com/raspberrypi/firmware)、[bluez-firmware](https://github.com/RPi-Distro/bluez-firmware)、[firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
- 构建文件系统的源仓库：[openEuler-20.03-LTS](http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
- 镜像内置源仓库：[openEuler 20.03 LTS 源仓库](https://gitee.com/openeuler/raspberrypi/blob/master/config/openEuler-20.03-LTS.repo)

#### 更新说明

##### 默认时区

设置默认时区为中国标准时间 (东八区)。

##### 主机名

设置主机名（hostname）为 openEuler。

##### 音频

默认开启音频。

##### HCI UART protocol Broadcom

设置 CONFIG_SERIAL_DEV_CTRL_TTYPORT 和 CONFIG_BT_HCIUART_BCM 为 'y'，将 Broadcom 协议编译进内核。Broadcom 协议支持为 Broadcom 蓝牙控制器启用基于串行端口接口的 Bluetooth HCI。

### 2020-04-15

#### 基本信息

- 发布时间：2020-04-15
- 大小：241 MiB
- 操作系统版本：openEuler 20.03 LTS
- 内核版本：4.19.90-2003.4.0.0036
- 固件来源：[firmware](https://github.com/raspberrypi/firmware)、[bluez-firmware](https://github.com/RPi-Distro/bluez-firmware)、[firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
- 构建文件系统的源仓库：[openEuler-20.03-LTS](http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
- 镜像内置源仓库：[openEuler 20.03 LTS 源仓库](https://gitee.com/openeuler/raspberrypi/blob/master/config/openEuler-20.03-LTS.repo)