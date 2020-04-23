# raspberrypi

English | [简体中文](./README.md)

This repository is main repository of openEuler RaspberryPi SIG, and provides scripts for building openEuler image for Raspberry Pi and related documents:

## How to collaborate

You can get introduction of openEuler RaspberryPi SIG from [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi)。

- Issues: welcome to collaborate with us by create new issues or reply opened issues. You can get repository list from [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi).
- Join Slack workspace: [openeuler-raspberrypi](https://openeuler-raspberrypi.slack.com )
  - [Invite link](https://join.slack.com/t/openeuler-raspberrypi/shared_invite/zt-dlqztpyb-GSgR98xIAI06SoTpFiJH6A), this link will be due on May 15th. We will update the link periodically.
- Weekly meeting
  - Time: Every week on Tue, 15:00 - 15:30 +0800
  - Zoom Meeting ID: 881 4204 8958
  - [Meeting Agenda](https://docs.google.com/document/d/1HuN7sWLiPuvGLqd-1tH1WAbzk51tgXpFBodp3dz_DBY/)
  - [Meeting Minutes](https://gitee.com/openeuler/raspberrypi/issues/I1EYZ6?from=project-issue)
- Warmly welcome to sumbit Pull Requests.

## Files and Directories

- [build_img.sh](build_img.sh): Script for building openEuler image for Raspberry Pi
- [config](./config/): config files for building image
- [documents](./documents/):
  - [Building openEuler image for Raspberry Pi](documents/openEuler镜像的构建.md)
  - [Cross-compile the kernel](documents/交叉编译内核.md)
  - [Install openEuler on a SD card](documents/树莓派刷机.md)
  - [How to use Raspberry Pi](documents/树莓派使用.md)

## How to download latest image

Alpha version of openEuler 20.03 LTS image for Raspberry Pi: <https://isrc.iscas.ac.cn/EulixOS/repo/dailybuild/1/isos/20200415/openEuler_20200415.img.xz>.

Basic information of the above image:

- Kernel version number: 4.19.90-2003.4.0.0036
- Firmware source: [firmware](https://github.com/raspberrypi/firmware), [bluez-firmware](https://github.com/RPi-Distro/bluez-firmware), [firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
- Repository of rootfs: [openEuler-20.03-LTS](http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
- Repository inside the image: [openEuler 20.03 LTS repository](https://gitee.com/openeuler/raspberrypi/blob/master/config/openEuler-20.03-LTS.repo)

## How to Use image

Refer to [Install openEuler on a SD card](documents/树莓派刷机.md) and [How to use Raspberry Pi](documents/树莓派使用.md) for details about how to use the image on Raspberry Pi.

## How to build image locally

### Prepare the environment

To build openEuler AArch64 image for Raspberry Pi, the requirements of runing scripts of this repository are as follows:

- OS: openEuler or CentOS 7/8
- Hardware: AArch64 hardware, such as Raspberry Pi

For other architecture hardwareyou can use [QEMU](https://www.qemu.org/) to build AArch64 system emulation.

### Run the scripts to build image

Refer to [Script for building openEuler image for Raspberry Pi](documents/openEuler镜像的构建.md) for details.

Build script: build_img.sh，which can be set 0/5/7 parameters.

1. Build with default parameters

`sudo bash build_img.sh`

2. Build with custom parameters

`sudo bash build_img.sh KERNEL_URL KERNEL_BRANCH KERNEL_DEFCONFIG DEFAULT_DEFCONFIG REPO_FILE_URL --cores MAKE_CORES`

or

`sudo bash build_img.sh KERNEL_URL KERNEL_BRANCH KERNEL_DEFCONFIG DEFAULT_DEFCONFIG REPO_FILE_URL`

The meaning of each parameter:

- KERNEL_URL：The URL of kernel source's repository，which defaults to `git@gitee.com:openeuler/raspberrypi-kernel.git`.
- KERNEL_BRANCH：The branch name of kernel source's repository，which defaults to `openEuler-1.0-LTS-raspi`.
- KERNEL_DEFCONFIG：The filename of configuration for compiling kernel, which defaults to `openeuler-raspi_defconfig`. The configuration file should be in the config directory or in arch/arm64/configs of the kernel source. If this configuration file does not exist, the script uses the next parameter: DEFAULT_DEFCONFIG.
- DEFAULT_DEFCONFIG：The filename of configuration for kernel, which defaults to `openeuler-raspi_defconfig`. The configuration file should be in arch/arm64/configs of the kernel source. If both KERNEL_DEFCONFIG and this file do not exist, the process of building image will exit.
- REPO_FILE：The URL or name of openEuler's file, which defaults to `openEuler-20.03-LTS.repo`. Caution, if REPO_FILE is a file name, please make sure this file in the config directory. Otherwise, if REPO_FILE is a URL, please make sure you can get a correct repo file from this URL.
- --cores：Followed by parameter MAKE_CORES
- MAKE_CORES：The number of parallel compilations, according to the actual number of CPU of the server running the script. The default is 18.
