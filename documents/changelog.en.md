## Feature Release Log

English | [简体中文](./changelog.md)

### 2020-08-10

#### Basic information

- Release date: 2020-08-10
- Size: 259 MiB
- OS version: openEuler 20.03 LTS
- Kernel version: 4.19.90-2005.2.0.0002
- Firmware source: [firmware](https://github.com/raspberrypi/firmware), [bluez-firmware](https://github.com/RPi-Distro/bluez-firmware), [firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
- Repository of rootfs: [openEuler-20.03-LTS](http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
- Repository inside the image: [openEuler 20.03 LTS repository](https://gitee.com/openeuler/raspberrypi/blob/master/scripts/config/openEuler-20.03-LTS.repo)

#### Updates

##### Kernel

Update to the latest stable version of openeuler: 4.19.90-2005.2.0.

### 2020-05-09

#### Basic information

- Release date: 2020-05-11
- Size: 245 MiB
- OS version: openEuler 20.03 LTS
- Kernel version: 4.19.90-2003.4.0.0036
- Firmware source: [firmware](https://github.com/raspberrypi/firmware), [bluez-firmware](https://github.com/RPi-Distro/bluez-firmware), [firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
- Repository of rootfs: [openEuler-20.03-LTS](http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
- Repository inside the image: [openEuler 20.03 LTS repository](https://gitee.com/openeuler/raspberrypi/blob/master/scripts/config/openEuler-20.03-LTS.repo)

#### Updates

##### Bluetooth

Start related services of bluetooth and bind Bluetooth devices by default.

### 2020-04-27

#### Basic information

- Release date: 2020-04-27
- Size: 240 MiB
- OS version: openEuler 20.03 LTS
- Kernel version: 4.19.90-2003.4.0.0036
- Firmware source: [firmware](https://github.com/raspberrypi/firmware), [bluez-firmware](https://github.com/RPi-Distro/bluez-firmware), [firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
- Repository of rootfs: [openEuler-20.03-LTS](http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
- Repository inside the image: [openEuler 20.03 LTS repository](https://gitee.com/openeuler/raspberrypi/blob/master/scripts/config/openEuler-20.03-LTS.repo)

#### Updates

##### Default time zone

Set default time zone as CST (UTC+8).

##### Hostname

Set hostname as openEuler.

##### Audio

Enable audio by default.

##### HCI UART protocol Broadcom

Set CONFIG_SERIAL_DEV_CTRL_TTYPORT and CONFIG_BT_HCIUART_BCM as 'y' to compile support for Broadcom protocol. The Broadcom protocol support enables Bluetooth HCI over serial port interface for Broadcom Bluetooth controllers.

### 2020-04-15

#### Basic information

- Release date: 2020-04-15
- Size: 241 MiB
- OS version: openEuler 20.03 LTS
- Kernel version: 4.19.90-2003.4.0.0036
- Firmware source: [firmware](https://github.com/raspberrypi/firmware), [bluez-firmware](https://github.com/RPi-Distro/bluez-firmware), [firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
- Repository of rootfs: [openEuler-20.03-LTS](http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
- Repository inside the image: [openEuler 20.03 LTS repository](https://gitee.com/openeuler/raspberrypi/blob/master/scripts/config/openEuler-20.03-LTS.repo)