# raspberrypi

[English](./README.cn.md) | 简体中文

本仓库是 openEuler 社区树莓派 SIG 组的主仓库，提供 SIG 组相关信息以及适用于树莓派的 openEuler 镜像的构建脚本和相关文档：

## 如何参与 SIG 组

SIG 组基本信息位于 [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi)。

- 建立或回复 issue：欢迎通过建立或回复 issue 来讨论，此 SIG 组维护的仓库列表可在 [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi) 中查看。
- 加入 Slack 群组：[openeuler-raspberrypi](https://openeuler-raspberrypi.slack.com )
  - [加入群组链接](https://join.slack.com/t/openeuler-raspberrypi/shared_invite/zt-dlqztpyb-GSgR98xIAI06SoTpFiJH6A)，此链接于 5 月 15 日失效，我们会定期更新。
- 每周 SIG 组会议：每周二下午 03:00 - 03:30 会进行一次讨论会议，Zoom Meeting ID: 881 4204 8958
  - [会议议题](https://docs.google.com/document/d/1HuN7sWLiPuvGLqd-1tH1WAbzk51tgXpFBodp3dz_DBY/)：每周会议前填写要讨论的议题，我们也会从 issue 列表中提取本周讨论的内容。
  - [会议记录](https://gitee.com/openeuler/raspberrypi/issues/I1EYZ6?from=project-issue)：每周会议结束后会议结论会更新在此 issue 中。
- 重要的事说三遍：**欢迎提交 PR！欢迎提交 PR！欢迎提交 PR！**

## 仓库目录

- [build_img.sh](build_img.sh): 构建 openEuler 树莓派镜像的主脚本
- [config](./config/): 构建使用的配置文件
- [documents](./documents/): 使用文档
  - [openEuler 镜像的构建](documents/openEuler镜像的构建.md)
  - [交叉编译内核](documents/交叉编译内核.md)
  - [树莓派刷机](documents/树莓派刷机.md)
  - [树莓派使用](documents/树莓派使用.md)

## 最新镜像

openEuler 20.03 LTS 的内测版本镜像：<https://isrc.iscas.ac.cn/EulixOS/repo/dailybuild/1/isos/20200415/openEuler_20200415.img.xz>。

该镜像的基本信息：

- 内核版本号：4.19.90-2003.4.0.0036
- 固件来源：[firmware](https://github.com/raspberrypi/firmware)、[bluez-firmware](https://github.com/RPi-Distro/bluez-firmware)、[firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
- 构建文件系统的源仓库：[openEuler-20.03-LTS](http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
- 镜像内置源仓库：[openEuler 20.03 LTS 源仓库](https://gitee.com/openeuler/raspberrypi/blob/master/config/openEuler-20.03-LTS.repo)

## 使用镜像

镜像刷写 SD 卡并使用树莓派，详见以下文档：

- [树莓派刷机](documents/树莓派刷机.md)
- [树莓派使用](documents/树莓派使用.md)

## 镜像构建

### 准备环境

本仓库的脚本运行环境要求如下：

- 操作系统：openEuler、CentOS 7、CentOS 8
- 架构：AArch64，如树莓派

其他架构可以使用 [QEMU](https://www.qemu.org/) 模拟器搭建 AArch64 运行环境。

### 构建镜像

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
