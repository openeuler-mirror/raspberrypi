# raspberrypi

#### Description

This repository provides scripts for building openEuler image for Raspberry Pi and related documents:

* [Script for building openEuler image for Raspberry Pi](build_img.sh)
* [Building openEuler image for Raspberry Pi](documents/openEuler镜像的构建.md)
* [Install openEuler on a SD card](documents/树莓派刷机.md)
* [How to use Raspberry Pi](documents/树莓派使用.md)


#### Build openEuler image

##### Prepare the environment

To build openEuler ARM64 image for Raspberry Pi, the requirements of runing scripts of this repository are as follows:
- OS: openEuler or Centos 7/8
- Architecture: ARM

For example, you can use [QEMU](https://www.qemu.org/) to build ARM system emulation or directly use an ARM hardware such as Raspberry Pi.

##### Run the scripts to build image

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
- REPO_FILE：The URL or name of openEuler's file, which defaults to `openEuler-1.0-LTS.repo`. Caution, if REPO_FILE is a file name, please make sure this file in the config directory. Otherwise, if REPO_FILE is a URL, please make sure you can get a correct repo file from this URL.
- --cores：Followed by parameter MAKE_CORES
- MAKE_CORES：The number of parallel compilations, according to the actual number of CPU of the server running the script. The default is 18.

#### Use image

Refer to [Install openEuler on a SD card](documents/树莓派刷机.md) and [How to use Raspberry Pi](documents/树莓派使用.md) for details about how to use the image on Raspberry Pi.