# raspberrypi

[English](./README.en.md) | 简体中文

本仓库是 openEuler 社区树莓派 SIG 组的主仓库，提供 SIG 组相关信息以及适用于树莓派的 openEuler 镜像的构建脚本和相关文档：

## 如何参与 SIG 组

SIG 组基本信息位于 [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi)。

- 建立或回复 issue：欢迎通过建立或回复 issue 来讨论，此 SIG 组维护的仓库列表可在 [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi) 中查看。
- 加入 Slack 群组：[openeuler-raspberrypi](https://openeuler-raspberrypi.slack.com )
  - [加入群组链接](https://join.slack.com/t/openeuler-raspberrypi/shared_invite/zt-gghnovr7-l05In14G3uAtuQIVZ3xH2A)，此链接于 9 月 7 日失效，我们会定期更新。
- SIG 组会议：每个月的第一个和第三个周二下午 03:00 - 03:30 会进行一次讨论会议，Zoom Meeting ID: 881 4204 8958
  - [会议议题](https://docs.google.com/document/d/1HuN7sWLiPuvGLqd-1tH1WAbzk51tgXpFBodp3dz_DBY/)：每周会议前填写要讨论的议题，我们也会从 issue 列表中提取本周讨论的内容。
  - [会议记录](https://gitee.com/openeuler/raspberrypi/issues/I1EYZ6?from=project-issue)：每周会议结束后会议结论会更新在此 issue 中。
- 重要的事说三遍：**欢迎提交 PR！欢迎提交 PR！欢迎提交 PR！**

## 仓库目录

- [scripts](./scripts): 构建 openEuler 树莓派镜像的脚本
  - [主机上构建](scripts/build-img.sh)
  - [Docker 容器中构建](scripts/build-img-docker.sh)
- [documents](./documents/): 使用文档
  - [openEuler 镜像的构建](documents/openEuler镜像的构建.md)
  - [交叉编译内核](documents/交叉编译内核.md)
  - [刷写镜像](documents/刷写镜像.md)
  - [树莓派使用](documents/树莓派使用.md)
  - [更新日志](documents/changelog.md)

## 最新镜像

openEuler 20.03 LTS 的内测版本镜像，[下载](https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.03-LTS-aarch64-raspi.img.xz)。


该镜像的基本信息：

- [更新日志](documents/changelog.md)
- 发布时间：2020-08-10
- 大小：259 MiB
- 操作系统版本：openEuler 20.03 LTS
- 内核版本：4.19.90-2005.2.0.0002
- 固件来源：[firmware](https://github.com/raspberrypi/firmware)、[bluez-firmware](https://github.com/RPi-Distro/bluez-firmware)、[firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
- 构建文件系统的源仓库：[openEuler-20.03-LTS](http://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
- 镜像内置源仓库：[openEuler 20.03 LTS 源仓库](https://gitee.com/openeuler/raspberrypi/blob/master/scripts/config/openEuler-20.03-LTS.repo)

## 使用镜像

镜像刷写 SD 卡并使用树莓派，详见以下文档：

- [刷写镜像](documents/刷写镜像.md)
- [树莓派使用](documents/树莓派使用.md)

## 镜像构建

### 准备环境

本仓库的脚本运行环境要求如下：

- 操作系统：openEuler、CentOS 7、CentOS 8
- 架构：AArch64，如树莓派

其他架构可以使用 [QEMU](https://www.qemu.org/) 模拟器搭建 AArch64 运行环境。

### 构建镜像

详细过程参见 [openEuler 镜像的构建](documents/openEuler镜像的构建.md)。

#### 快速构建（无需编译内核，推荐）

使用已有的树莓派内核、固件、蓝牙等 RPM 包构建镜像。

构建镜像需执行命令：

`sudo bash build-img-quick.sh -d DIR -r REPO -n IMAGE_NAME`

各个参数意义：

1.  -d, --dir DIR

    构建镜像和临时文件的输出目录，默认为脚本所在目录。如果 `DIR` 不存在则会自动创建。
    
    脚本运行结束后，会提示镜像的存储位置，默认保存在 `DIR/raspi_output/img/` 下。

2.  -r, --repo REPO_INFO

    开发源 repo 文件的 URL 或者路径，也可以是开发源中资源库的 baseurl 列表。注意，如果该参数为资源库的 baseurl 列表，该参数需要使用双引号，各个 baseurl 之间以空格隔开。
    
    默认使用脚本所在目录的 openEuler 文件夹下的 repo 文件。下面分别举例：
    - 开发源 repo 文件的 URL：`https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo`
    - 开发源的 repo 文件路径：`/opt/raspi-image-build/openEuler/openEuler-20.03-LTS.repo`
    - 资源库的 baseurl 列表：`"http://repo.openeuler.org/openEuler-20.03-LTS/OS/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/EPOL/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/source"`

3.  -n, --name IMAGE_NAME
    
    构建的镜像名称。
    
    例如，`openEuler-20.03-LTS.img`。默认为`openEuler-20.09-aarch64-raspi.img`，或者根据 `-r, --repo REPO_INFO` 参数自动生成。

4.  -h, --help
    
    显示帮助信息。

#### 完全构建（包括编译内核）

包含编译内核、下载树莓派相关固件等过程，速度相对较慢。

这里，提供两种构建方式。

##### 主机上构建

构建镜像需执行命令：

`sudo bash build-img.sh -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO --cores N`

各个参数意义：

1.  -n, --name IMAGE_NAME
    
    构建的镜像名称。
    
    例如，`openEuler-20.03-LTS.img`。默认为`openEuler-20.03-LTS-aarch64-raspi.img`，或者根据 `-r, --repo REPO_INFO` 参数自动生成。

2.  -k, --kernel KERNEL_URL
    
    内核源码仓库的项目地址，默认为 `https://gitee.com/openeuler/raspberrypi-kernel.git`。

3.  -b, --branch KERNEL_BRANCH

    内核源码的对应分支，默认为 `master`。

4.  -c, --config KERNEL_DEFCONFIG
    
    内核编译使用的配置文件名称或路径，默认为 `openeuler-raspi_defconfig`。如果该参数为配置文件名称，请确保该文件在内核源码的目录 arch/arm64/configs 下。

5.  -r, --repo REPO_INFO

    开发源 repo 文件的 URL 或者路径，也可以是开发源中资源库的 baseurl 列表。注意，如果该参数为资源库的 baseurl 列表，该参数需要使用双引号，各个 baseurl 之间以空格隔开。
    
    默认使用脚本所在目录的 openEuler 文件夹下的 repo 文件。下面分别举例：
    - 开发源 repo 文件的 URL：`https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo`
    - 开发源的 repo 文件路径：`/opt/raspi-image-build/openEuler/openEuler-20.03-LTS.repo`
    - 资源库的 baseurl 列表：`"http://repo.openeuler.org/openEuler-20.03-LTS/OS/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/EPOL/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/source"`

6.  --cores N

    并行编译的数量，根据运行脚本的宿主机 CPU 实际数目设定，默认为可用的 CPU 总数。

##### Docker 容器内构建

构建镜像需执行命令：

`sudo bash build-img-docker.sh -d DOCKER_FILE -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO --cores N`

注意！！！运行该脚本前，需安装 Docker 运行环境。该脚本会自动将 DOCKER_FILE 参数对应的 Docker 镜像导入本机系统中。

除参数 DOCKER_FILE 外，剩余参数与[主机上构建](#主机上构建)中对应参数一致：

1.  -d, --docker DOCKER_FILE

    Docker 镜像的 URL 或者路径， 默认为 `https://repo.openeuler.org/openEuler-20.03-LTS/docker_img/aarch64/openEuler-docker.aarch64.tar.xz`。使用该默认参数时，脚本会自动下载 openEuler 20.03 LTS 的 Docker 镜像，并导入本机系统中。