# raspberrypi

English | [简体中文](./README.md)

This repository is main repository of openEuler RaspberryPi SIG, and provides scripts for building openEuler image for Raspberry Pi and related documents.

In addition, RaspberryPi SIG also aims to migrate openEuler to other SoCs, such as [Rockchip](https://gitee.com/openeuler/rockchip).

<!-- TOC -->

- [raspberrypi](#raspberrypi)
    - [How to collaborate](#how-to-collaborate)
    - [File description](#file-description)
    - [How to download latest image](#how-to-download-latest-image)
    - [How to Use image](#how-to-use-image)
    - [How to build image locally](#how-to-build-image-locally)
        - [Prepare the environment](#prepare-the-environment)
        - [Run the scripts to build image](#run-the-scripts-to-build-image)
            - [Quickly Build without kernel compilation(Recommended)](#quickly-build-without-kernel-compilationrecommended)
            - [Build with kernel compilation](#build-with-kernel-compilation)
                - [Build on host](#build-on-host)
                - [Build in a Docker container](#build-in-a-docker-container)

<!-- /TOC -->

## How to collaborate

You can get introduction of openEuler RaspberryPi SIG from [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi).

- Issues: welcome to collaborate with us by create new issues or reply opened issues. You can get repository list from [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi).
- Join Slack workspace: [openeuler-raspberrypi](https://openeuler-raspberrypi.slack.com )
  - [Invite link](https://join.slack.com/t/openeuler-raspberrypi/shared_invite/zt-kp6de2va-2t4k6JqvNWKogtYv1Kg3pQ): This link will be due on Feb 11th, 2021. We will update the link periodically.
- Weekly meeting schedule
  - Meeting Time: The 1st and 3rd Wednesday of each month, 20:00 - 20:30 UTC+8.
  - Meeting Link: There are two methods to get the meeting link which will be updated before each meeting.
    - Log in to the [openEuler Community](https://openeuler.org/) website, then view the booking information of `sig-RaspberryPi例会` in the meeting calendar.
    - Search `openEuler` in mini programs of Wechat, add `openEuler mini program`. Then click `会议` and view the booking information of `sig-RaspberryPi例会`.
  - [Meeting Agenda](https://etherpad.openeuler.org/p/sig-RaspberryPi-meetings)
  - [Meeting Minutes](https://gitee.com/openeuler/raspberrypi/issues/I1EYZ6)
- Warmly welcome to sumbit Pull Requests.

## File description

>![](documents/public_sys-resources/icon-note.gif) **NOTE: **   
>- Recommendation: use the openEuler-RaspberryPi images provided in the chapter [How to download latest image](#how-to-download-latest-image) of this documentation.
>- If you need to customize the image, please refer to [Building openEuler image for Raspberry Pi](documents/openEuler镜像的构建.md) and [Cross-compile the kernel](documents/交叉编译内核.md).

- [documents](./documents/):
  - [Install openEuler on a SD card](documents/刷写镜像.md)
  - [How to use Raspberry Pi](documents/树莓派使用.md)
  - [Building openEuler image for Raspberry Pi](documents/openEuler镜像的构建.md)
  - [Cross-compile the kernel](documents/交叉编译内核.md)
  - [Emulate Raspberry Pi with QEMU](documents/QEMU启动树莓派.md)
  - [openEuler 20.03 LTS SP1 alpha version ChangeLog](documents/changelog/changelog-20.03-LTS-SP1.en.md)
  - [openEuler 20.03 LTS SP1 alpha version (UKUI desktop environment and Chinese input method) ChangeLog](documents/changelog/changelog-20.03-LTS-SP1-UKUI.en.md)
  - [openEuler 20.03 LTS SP1 alpha version (DDE desktop environment and Chinese input method) ChangeLog](documents/changelog/changelog-20.03-LTS-SP1-DDE.en.md)
  - [openEuler 21.03 alpha version ChangeLog](documents/changelog/changelog-21.03.en.md)
  - [openEuler 21.03 alpha version (UKUI desktop and Chinese input method) ChangeLog](documents/changelog/changelog-21.03-UKUI.en.md)
  - [openEuler 21.03 alpha version (DDE desktop and Chinese input method) ChangeLog](documents/changelog/changelog-21.03-DDE.en.md)
  - [openEuler 21.03 alpha version (Xfce desktop and Chinese input method) ChangeLog](documents/changelog/changelog-21.03-Xfce.en.md)
- [scripts](./scripts): Script for building openEuler image for Raspberry Pi
  - [Quickly Build (without kernel compilation)](scripts/build-image.sh)
  - [Build on host (with kernel compilation)](scripts/build-image-common.sh)
  - [Build in a Docker container (with kernel compilation)](scripts/build-image-docker.sh)

## How to download latest image

Basic information of the image is as follows. [more images](documents/images.en.md)

<table><thead align="left"><tr>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Version</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>System user(password)</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Change log</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Release date</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Size</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Kernel version</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Repository of rootfs</strong></p></th>
</tr></thead>
<tbody>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.03-LTS-SP1-raspi-aarch64-alpha4.img.xz">openEuler 20.03 LTS SP1 alpha4</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-20.03-LTS-SP1.en.md">ChangeLog</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/04/12</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>236 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90-2104.1.0.0017</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/20.03:/LTS:/SP1/standard_aarch64/aarch64/">openEuler 20.03 LTS SP1 repository built daily</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.03-LTS-SP1-UKUI-raspi-aarch64-alpha4.img.xz">openEuler 20.03 LTS SP1 alpha4 (UKUI desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-20.03-LTS-SP1-UKUI.en.md">ChangeLog</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/04/12</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.1 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90-2104.1.0.0017</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/20.03:/LTS:/SP1/standard_aarch64/aarch64/">openEuler 20.03 LTS SP1 repository built daily</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.03-LTS-SP1-DDE-raspi-aarch64-alpha4.img.xz">openEuler 20.03 LTS SP1 alpha4 (DDE desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-20.03-LTS-SP1-DDE.en.md">ChangeLog</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/04/12</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.1 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90-2104.1.0.0017</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/20.03:/LTS:/SP1/standard_aarch64/aarch64/">openEuler 20.03 LTS SP1 repository built daily</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-20.03-LTS-SP1/raspi_img/aarch64/openEuler-20.03-LTS-SP1-raspi-aarch64.img.xz">openEuler 20.03 LTS SP1</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>root (openeuler)</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>-</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2020/12/28</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>266 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90-2012.3.0.0011</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS-SP1/generic.repo">openEuler 20.03 LTS SP1 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-21.03-raspi-aarch64-alpha1.img.xz">openEuler 21.03 alpha1</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-21.03.en.md">ChangeLog</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/04/12</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>220 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-4.18.0.9</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/21.03/standard_aarch64/aarch64/">openEuler 21.03 repository built daily</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-21.03-UKUI-raspi-aarch64-alpha1.img.xz">openEuler 21.03 alpha1 (UKUI desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-21.03-UKUI.en.md">ChangeLog</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/04/12</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.1 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-4.18.0.9</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/21.03/standard_aarch64/aarch64/">openEuler 21.03 repository built daily</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-21.03-DDE-raspi-aarch64-alpha1.img.xz">openEuler 21.03 alpha1 (DDE desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-21.03-DDE.en.md">ChangeLog</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/04/12</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.0 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-4.18.0.9</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/21.03/standard_aarch64/aarch64/">openEuler 21.03 repository built daily</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-21.03-Xfce-raspi-aarch64-alpha1.img.xz">openEuler 21.03 alpha1 (Xfce desktop and Chinese input method)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-21.03-Xfce.en.md">ChangeLog</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/04/12</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.8 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-4.18.0.9</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/21.03/standard_aarch64/aarch64/">openEuler 21.03 repository built daily</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-21.03/raspi_img/openEuler-21.03-raspi-aarch64.img.xz">openEuler 21.03</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>root (openeuler)</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>-</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/04/01</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>237 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-4.17.0.8</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-21.03/generic.repo">openEuler 21.03 repository</a></td>
</tr>
</tbody></table>

Other information:
- Firmware source: [firmware](https://github.com/raspberrypi/firmware), [bluez-firmware](https://github.com/RPi-Distro/bluez-firmware), [firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)

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
>Two openEuler versions are currently supported, i.e., 20.09, 20.03 LTS SP1 and 21.03.
>When building an image with Xfce/UKUI/DDE desktop environment, you need to pay attention to three issues:
>1. For building an image with Xfce desktop environment, note that only openEuler 21.03 is currently supported.
>2. For building an image with DDE desktop environment, note that only openEuler 20.03 LTS SP1 and 21.03 are currently supported.
>3. Need to set the parameter `-s/--spec`. Please refer to the description of this parameter for details.

Build images with packages of raspberrypi-kernel, raspberrypi-firmware, and raspberrypi-bluetooth.

Run the following command to build an image:

`sudo bash build-image.sh -d DIR -r REPO -n IMAGE_NAME -s SPEC`

The meaning of each parameter:

1.  -d, --dir DIR

    The directory for storing the image and other temporary files, which defaults to be the directory in which the script resides. If the `DIR` does not exist, it will be created automatically.

    After building the image, you can find the image in `DIR/raspi_output/img/` as shown in the script output.

2.  -r, --repo REPO_INFO

    The URL/path of target repo file, or the list of repositories' baseurls. Note that, the baseurls should be separated by space and enclosed in double quotes.

    Examples are as follows:

    - The URL of target repo file: `https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-21.03/generic.repo`.
    - The path of target repo file: 
        - `./openEuler-21.03.repo`: for building openEuler 21.03 image, refer to <https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-21.03/generic.repo> for details.
    - List of repo's baseurls: `"http://repo.openeuler.org/openEuler-21.03/OS/aarch64/ http://repo.openeuler.org/openEuler-21.03/EPOL/aarch64/"`.

3.  -n, --name IMAGE_NAME

    The image name to be built.

    For example, `openEuler-21.03.img`. The default is `openEuler-raspi-aarch64.img`, or it is automatically generated based on parameter: `-n, --name IMAGE_NAME`.

4.  -s, --spec SPEC

    Specify the image version:
    - `headless`, image without desktop environments.
    - `xfce`, image with Xfce desktop environment and related softwares including CJK fonts and IME.
    - `ukui`, image with UKUI desktop environment and fundamental softwares without CJK fonts and IME.
    - `dde`, image with DDE desktop environment and fundamental softwares without CJK fonts and IME.
    - The file path of rpmlist, the file contains a list of the software to be installed in the image, refer to [rpmlist](./scripts/config/rpmlist) for details.

    The default is `headless`.

5.  -h, --help

    Display help information.

#### Build with kernel compilation

Here, we provide two approaches to build an image, which both include compiling kernel and downloading firmware files of Raspberry Pi. These approaches will take considerably longer.

>![](documents/public_sys-resources/icon-notice.gif) **NOTICE:**  
>Three openEuler versions are currently supported, i.e., 20.03 LTS, 20.09, 20.03 LTS SP1 and 21.03.
>When building an image with Xfce/UKUI/DDE desktop environment, you need to pay attention to four issues:
>1. For building an image with Xfce desktop environment, note that only openEuler 21.03 is currently supported. You need to select the branch [openEuler-21.03](https://gitee.com/openeuler/kernel/tree/openEuler-21.03/) of the [openEuler kernel](https://gitee.com/openeuler/kernel), i.e., set the parameter `-k/--kernel` to `git@gitee.com:openeuler/kernel.git` and set the parameter `-b/--branch` to `openEuler-21.03`.
>2. For building an image with UKUI desktop environment, note that only openEuler 20.09, 20.03 LTS SP1 and 21.03 are currently supported.
>    -  openEuler 20.09: You need to select the branch [openEuler-20.09](https://gitee.com/openeuler/raspberrypi-kernel/tree/openEuler-20.09/) of the [openEuler-RaspberryPi kernel](https://gitee.com/openeuler/raspberrypi-kernel), i.e., set the parameter `-k/--kernel` to `git@gitee.com:openeuler/raspberrypi-kernel.git` and set the parameter `-b/--branch` to `openEuler-20.09`.
>    -  openEuler 20.03 LTS SP1: You need to select the branch [openEuler-20.03-LTS](https://gitee.com/openeuler/raspberrypi-kernel/tree/openEuler-20.09/) of the [openEuler-RaspberryPi kernel](https://gitee.com/openeuler/raspberrypi-kernel), i.e., set the parameter `-k/--kernel` to `git@gitee.com:openeuler/raspberrypi-kernel.git` and set the parameter `-b/--branch` to `openEuler-20.03-LTS`.
>    -  openEuler 21.03: You need to select the branch [openEuler-21.03](https://gitee.com/openeuler/kernel/tree/openEuler-21.03/) of the [openEuler kernel](https://gitee.com/openeuler/kernel), i.e., set the parameter `-k/--kernel` to `git@gitee.com:openeuler/kernel.git` and set the parameter `-b/--branch` to `openEuler-21.03`.
>3. For building an image with DDE desktop environment, note that only openEuler 20.03 LTS SP1 and 21.03 are currently supported.
>    -  openEuler 20.03 LTS SP1: You need to select the branch [openEuler-20.03-LTS](https://gitee.com/openeuler/raspberrypi-kernel/tree/openEuler-20.09/) of the [openEuler-RaspberryPi kernel](https://gitee.com/openeuler/raspberrypi-kernel), i.e., set the parameter `-k/--kernel` to `git@gitee.com:openeuler/raspberrypi-kernel.git` and set the parameter `-b/--branch` to `openEuler-20.03-LTS`.
>    -  openEuler 21.03: You need to select the branch [openEuler-21.03](https://gitee.com/openeuler/kernel/tree/openEuler-21.03/) of the [openEuler kernel](https://gitee.com/openeuler/kernel), i.e., set the parameter `-k/--kernel` to `git@gitee.com:openeuler/kernel.git` and set the parameter `-b/--branch` to `openEuler-21.03`.
>4. Need to set the parameter `-s/--spec`. Please refer to the description of this parameter for details.

##### Build on host

Run the following command to build an image:

`sudo bash build-image-common.sh -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO -s SPEC --cores N`

After building the image, you can find the image in `raspi_output_common/img/` of the directory in which the script resides as shown in the script output.

The meaning of each parameter:

1.  -n, --name IMAGE_NAME

    The image name to be built.

    For example, `openEuler-20.03-LTS-SP1.img`. The default is `openEuler-raspi-aarch64.img`, or it is automatically generated based on parameter: `-n, --name IMAGE_NAME`.

2.  -k, --kernel KERNEL_URL

    The URL of kernel source repository, which defaults to `https://gitee.com/openeuler/raspberrypi-kernel.git`. You can set the parameter as `git@gitee.com:openeuler/raspberrypi-kernel.git` or `git@gitee.com:openeuler/kernel.git` according to the requirement.

3.  -b, --branch KERNEL_BRANCH

    The branch name of kernel source repository, which defaults to `master`. `openEuler-20.03-LTS` or `openEuler-20.09` is recommended.

4.  -c, --config KERNEL_DEFCONFIG

    The filename/path of configuration for compiling kernel, which defaults to `openeuler-raspi_defconfig`. If this parameter is the filename of configuration, please make sure the configuration file in arch/arm64/configs of the kernel source.

5.  -r, --repo REPO_INFO

    The URL/path of target repo file, or the list of repositories' baseurls. Note that, the baseurls should be separated by space and enclosed in double quotes.

    Examples are as follows:

    - The URL of target repo file: `https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-20.03-LTS-SP1/generic.repo`
    - The path of target repo file:
        - `./openEuler-20.03-LTS-SP1.repo`: for building openEuler 20.03 LTS SP1 image, refer to <https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS-SP1/generic.repo> for details.
    - List of repo's baseurls: `"http://repo.openeuler.org/openEuler-20.03-LTS-SP1/OS/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS-SP1/EPOL/aarch64/"`.

6.  -s, --spec SPEC

    Specify the image version:
    - `headless`, image without desktop environments.
    - `xfce`, image with Xfce desktop environment and related softwares including CJK fonts and IME.
    - `ukui`, image with UKUI desktop environment and fundamental softwares without CJK fonts and IME.
    - `dde`, image with DDE desktop environment and fundamental softwares without CJK fonts and IME.
    - The file path of rpmlist, the file contains a list of the software to be installed in the image, refer to [rpmlist](./scripts/config-common/rpmlist) for details.

    The default is `headless`.

7.  --cores N

    The number of parallel compilations, according to the actual number of CPU of the host running the script. The default is the number of processing units available.

##### Build in a Docker container

Run the following command to build an image:

`sudo bash build-image-docker.sh -d DOCKER_FILE -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO --cores N`

After building the image, you can find the image in `raspi_output_common/img/` of the directory in which the script resides.

Caution, before running the script, you need to install Docker. The script will automatically import the Docker image into the local system according to the script's parameter: DOCKER_FILE.

In addition to the parameter DOCKER_FILE, the other parameters are the same as the corresponding parameters in [Build on host](#Build-on-host):

1.  -d, --docker DOCKER_FILE

    The URL/path of the Docker image, which defaults to `https://repo.openeuler.org/openEuler-20.03-LTS-SP1/docker_img/aarch64/openEuler-docker.aarch64.tar.xz`. With the default parameter, the script will automatically download the Docker image of openEuler 20.03 LTS SP1 and import it into the local system.
