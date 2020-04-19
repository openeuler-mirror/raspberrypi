# raspberrypi

#### 介绍

openEuler 20.03 LTS 的内测版本镜像：<https://isrc.iscas.ac.cn/EulixOS/repo/dailybuild/1/isos/20200415/openEuler_20200415.img.xz>。

该镜像的基本信息：

- 内核版本号：4.19.90-2003.4.0.0036
- 固件来源：[firmware](https://github.com/raspberrypi/firmware)、[bluez-firmware](https://github.com/RPi-Distro/bluez-firmware)、[firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
- 构建文件系统的源仓库：[openEuler-20.03-LTS](http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
- 镜像内置源仓库：[openEuler 20.03 LTS 源仓库](https://gitee.com/openeuler/raspberrypi/blob/master/config/openEuler-20.03-LTS.repo)

本仓库提供适用于树莓派的 openEuler 镜像的构建脚本和相关文档：

* [适用于树莓派的 openEuler 镜像构建脚本](build_img.sh)
* [openEuler 镜像的构建](documents/openEuler镜像的构建.md)
* [交叉编译内核](documents/交叉编译内核.md)
* [树莓派刷机](documents/树莓派刷机.md)
* [树莓派使用](documents/树莓派使用.md)

#### openEuler镜像构建

##### 准备环境

用于生成 openEuler AArch64 的树莓派镜像。

本仓库的脚本运行环境要求：
- 操作系统：openEuler 或 Centos 7/8
- 架构：AArch64

可以使用 [QEMU](https://www.qemu.org/) 模拟器搭建 AArch64 运行环境或者直接使用 AArch64 架构的主机（例如，树莓派）。

##### 构建镜像

详细过程参见 [openEuler 镜像的构建](documents/openEuler镜像的构建.md)。

构建脚本 build_img.sh，其后可设置 0/5/7 个参数。

1. 使用脚本默认参数构建

`sudo bash build_img.sh`

2. 自行设置参数构建

`sudo bash build_img.sh <KERNEL_URL> <KERNEL_BRANCH>  <KERNEL_DEFCONFIG> <DEFAULT_DEFCONFIG> <REPO_FILE_URL> --cores <MAKE_CORES>`

或

`sudo bash build_img.sh <KERNEL_URL> <KERNEL_BRANCH>  <KERNEL_DEFCONFIG> <DEFAULT_DEFCONFIG> <REPO_FILE_URL>`

其中，各个参数意义：

- KERNEL_URL：内核源码的项目地址，默认为 `git@gitee.com:openeuler/raspberrypi-kernel.git`。
- KERNEL_BRANCH：内核源码的对应分支，默认为 `openEuler-1.0-LTS-raspi`。
- KERNEL_DEFCONFIG：内核编译使用的配置文件名称，默认为 `openeuler-raspi_defconfig`，在本目录的 config 目录下或内核源码的目录 arch/arm64/configs 下。如果该文件不存在则使用配置文件 DEFAULT_DEFCONFIG。
- DEFAULT_DEFCONFIG：内核默认配置文件名称，默认为 `openeuler-raspi_defconfig`，在内核源码的目录 arch/arm64/configs 下。如果 KERNEL_DEFCONFIG 和该文件均不存在则退出镜像构建过程。
- REPO_FILE：openEuler 开发源的 repo 文件的 URL 或者文件名称， 默认为 `openEuler-20.03-LTS.repo`。注意，如果 REPO_FILE 为文件名称，需要保证该文件在脚本 build_img.sh 所在目录的 config 文件夹下。
- --cores：其后跟参数 MAKE_CORES。
- MAKE_CORES：并行编译的数量，根据运行脚本的服务器CPU实际数目设定，默认为 18。

#### 镜像使用

镜像刷写 SD 卡并使用树莓派，详见 [树莓派刷机](documents/树莓派刷机.md) 和 [树莓派使用](documents/树莓派使用.md)。