# raspberrypi

English | [简体中文](./README.md)

This repository is main repository of openEuler RaspberryPi SIG, and provides scripts for building openEuler image for Raspberry Pi and related documents:

## How to collaborate

You can get introduction of openEuler RaspberryPi SIG from [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi).

- Issues: welcome to collaborate with us by create new issues or reply opened issues. You can get repository list from [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi).
- Join Slack workspace: [openeuler-raspberrypi](https://openeuler-raspberrypi.slack.com )
  - [Invite link](https://join.slack.com/t/openeuler-raspberrypi/shared_invite/zt-gghnovr7-l05In14G3uAtuQIVZ3xH2A), this link will be due on Sep 7th. We will update the link periodically.
- Weekly meeting
  - Time: The first and third Tuesday of every month, 15:00 - 15:30 +0800
  - Zoom Meeting ID: 881 4204 8958
  - [Meeting Agenda](https://docs.google.com/document/d/1HuN7sWLiPuvGLqd-1tH1WAbzk51tgXpFBodp3dz_DBY/)
  - [Meeting Minutes](https://gitee.com/openeuler/raspberrypi/issues/I1EYZ6?from=project-issue)
- Warmly welcome to sumbit Pull Requests.

## Files and Directories

- [scripts](./scripts): Script for building openEuler image for Raspberry Pi
  - [Quickly Build(without kernel compilation)](scripts/build-image.sh)
  - [Build on host(with kernel compilation)](scripts/build-image-common.sh)
  - [Build in a Docker container(with kernel compilation)](scripts/build-image-docker.sh)
- [documents](./documents/):
  - [Building openEuler image for Raspberry Pi](documents/openEuler镜像的构建.md)
  - [Cross-compile the kernel](documents/交叉编译内核.md)
  - [Install openEuler on a SD card](documents/刷写镜像.md)
  - [How to use Raspberry Pi](documents/树莓派使用.md)
  - [openEuler 20.03 LTS ChangeLog](documents/changelog.en.md)
  - [openEuler 20.09 ChangeLog](documents/changelog-20.09.en.md)

## How to download latest image

1.  openEuler 20.03 LTS

    Alpha version of openEuler 20.03 LTS image for Raspberry Pi, [download](https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.03-LTS-aarch64-raspi.img.xz).

    Basic information of the above image:

    - [ChangeLog](documents/changelog.en.md)
    - Release date: 2020-08-10
    - Size: 259 MiB
    - OS version: openEuler 20.03 LTS
    - Kernel version: 4.19.90-2005.2.0.0002
    - Firmware source: [firmware](https://github.com/raspberrypi/firmware), [bluez-firmware](https://github.com/RPi-Distro/bluez-firmware), [firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
    - Repository of rootfs: [openEuler 20.03 LTS](rhttp://repo.openeuler.org/openEuler-20.03-LTS/everything/aarch64/)
    - Repository inside the image: [openEuler 20.03 LTS repository](https://gitee.com/openeuler/raspberrypi/blob/master/scripts/config-common/openEuler-20.03-LTS.repo)

2.  openEuler 20.09

    Alpha version of openEuler 20.09 image for Raspberry Pi, [download](https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.09-aarch64-raspi.img.xz).

    Basic information of the above image:

    - [ChangeLog](documents/changelog-20.09.en.md)
    - Release date: 2020-09-04
    - Size: 237 MiB
    - OS version: openEuler 20.09
    - Kernel version: 4.19.140-2008.3.0.0001
    - Firmware source: [firmware](https://github.com/raspberrypi/firmware), [bluez-firmware](https://github.com/RPi-Distro/bluez-firmware), [firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)
    - Repository of rootfs: [openEuler 20.09 repository built daily](http://119.3.219.20:82/openEuler:/Mainline/standard_aarch64/)
    - Repository inside the image: [openEuler 20.09 repository](https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.09/generic.repo)

## How to Use image

Refer to [Install openEuler on a SD card](documents/刷写镜像.md) and [How to use Raspberry Pi](documents/树莓派使用.md) for details about how to use the image on Raspberry Pi.

## How to build image locally

### Prepare the environment

To build openEuler AArch64 image for Raspberry Pi, the requirements of runing scripts of this repository are as follows:

- OS: openEuler or CentOS 7/8
- Hardware: AArch64 hardware, such as Raspberry Pi

For other architecture hardware, you can use [QEMU](https://www.qemu.org/) to build AArch64 system emulation.

### Run the scripts to build image

Refer to [Script for building openEuler image for Raspberry Pi](documents/openEuler镜像的构建.md) for details.

#### Quickly Build without kernel compilation(Recommended)

>![](documents/public_sys-resources/icon-notice.gif) **NOTICE:**
>Only openEuler 20.09 is supported currently.

Build images with packages of raspberrypi-kernel, raspberrypi-firmware, and raspberrypi-bluetooth.

Run the following command to build an image:

`sudo bash build-image.sh -d DIR -r REPO -n IMAGE_NAME`

The meaning of each parameter:

1.  -d, --dir DIR

    The directory for storing the image and other temporary files, which defaults to be the directory in which the script resides. If the `DIR` does not exist, it will be created automatically.

    After building the image, you can find the image in `DIR/raspi_output/img/` as shown in the script output.

2.  -r, --repo REPO_INFO

    The URL/path of target repo file, or the list of repositories' baseurls. Note that, the baseurls should be separated by space and enclosed in double quotes.

    Examples are as follows:

    - The URL of target repo file: *currently unavailable*
    - The path of target repo file: `./openEuler-20.09.repo`

        The content of the repo file is as follows:
        ```
        [MAINLINE]
        name=MAINLINE
        baseurl=http://119.3.219.20:82/openEuler:/Mainline/standard_aarch64/
        enabled=1
        gpgcheck=0

        [EPOL]
        name=EPOL
        baseurl=http://119.3.219.20:82/openEuler:/Epol/standard_aarch64/
        enabled=1
        gpgcheck=0
        ```
    - List of repo's baseurls: `"http://119.3.219.20:82/openEuler:/Mainline/standard_aarch64/ http://119.3.219.20:82/openEuler:/Epol/standard_aarch64/"`

3.  -n, --name IMAGE_NAME

    The image name to be built.

    For example, `openEuler-20.09.img`. The default is `openEuler-aarch64-raspi.img`, or it is automatically generated based on parameter: `-r, --repo REPO_INFO`.

4.  -s, --spec SPEC

    The specification to be built:
    - `headless`, image without desktop environments。
    - `standard`，image with Xfce desktop environment and fundamental softwares but without CJK fonts and IME.
    - `full`，image with Xfce desktop environment and related softwares including CJK fonts and IME.

    The default is `headless`.

5.  -h, --help

    Display help information.

#### Build with kernel compilation

Here, we provide two approaches to build an image, which both include compiling kernel and downloading firmware files of Raspberry Pi. These approaches will take considerably longer.

##### Build on host

Run the following command to build an image:

`sudo bash build-image-common.sh -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO --cores N`

The meaning of each parameter:

1.  -n, --name IMAGE_NAME

    The image name to be built.

    For example, `openEuler-20.03-LTS.img`. The default is `openEuler-aarch64-raspi.img`, or it is automatically generated based on parameter: `-r, --repo REPO_INFO`.

2.  -k, --kernel KERNEL_URL

    The URL of kernel source's repository, which defaults to `https://gitee.com/openeuler/raspberrypi-kernel.git`.

3.  -b, --branch KERNEL_BRANCH

    The branch name of kernel source's repository, which defaults to `master`.

4.  -c, --config KERNEL_DEFCONFIG

    The filename/path of configuration for compiling kernel, which defaults to `openeuler-raspi_defconfig`. If this parameter is the filename of configuration, please make sure the configuration file in arch/arm64/configs of the kernel source.

5.  -r, --repo REPO_INFO

    The URL/path of target repo file, or the list of repositories' baseurls. Note that, the baseurls should be separated by space and enclosed in double quotes.

    Examples are as follows:

    - The URL of target repo file: `https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo`
    - The path of target repo file: `./openEuler-20.03-LTS.repo`

        Refer to `https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo` for details about the content of the repo file.
    - List of repo's baseurls: `"http://repo.openeuler.org/openEuler-20.03-LTS/OS/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/EPOL/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/source"`

6.  --cores N

    The number of parallel compilations, according to the actual number of CPU of the host running the script. The default is the number of processing units available.

##### Build in a Docker container

Run the following command to build an image:

`sudo bash build-image-docker.sh -d DOCKER_FILE -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO --cores N`

Caution, before running the script, you need to install Docker. The script will automatically import the Docker image into the local system according to the script's parameter: DOCKER_FILE.

In addition to the parameter DOCKER_FILE, the other parameters are the same as the corresponding parameters in [Build on host](#Build-on-host):

1.  -d, --docker DOCKER_FILE

    The URL/path of the Docker image, which defaults to `https://repo.openeuler.org/openEuler-20.03-LTS/docker_img/aarch64/openEuler-docker.aarch64.tar.xz`. With the default parameter, the script will automatically download the Docker image of openEuler 20.03 LTS and import it into the local system.
