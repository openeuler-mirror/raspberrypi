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
  - [Quickly Build (without kernel compilation)](scripts/build-image.sh)
  - [Build on host (with kernel compilation)](scripts/build-image-common.sh)
  - [Build in a Docker container (with kernel compilation)](scripts/build-image-docker.sh)
- [documents](./documents/):
  - [Building openEuler image for Raspberry Pi](documents/openEuler镜像的构建.md)
  - [Cross-compile the kernel](documents/交叉编译内核.md)
  - [Install openEuler on a SD card](documents/刷写镜像.md)
  - [How to use Raspberry Pi](documents/树莓派使用.md)
  - [openEuler 20.03 LTS alpha version ChangeLog](documents/changelog/changelog.en.md)
  - [openEuler 20.09 alpha version ChangeLog](documents/changelog/changelog-20.09.en.md)
  - [openEuler 20.09 alpha version (with Xfce desktop environment) ChangeLog](documents/changelog/changelog-20.09-desktop.en.md)
  - [openEuler 20.09 ChangeLog](documents/changelog/changelog-20.09-release.en.md)

## How to download latest image

Basic information of the image is as follows:

<table><thead align="left"><tr>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Version</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>System user(password)</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Change log</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Release date</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Size</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Kernel version</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>Repository of rootfs</strong></p></th>
</tr></thead>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.03-LTS-raspi-aarch64-alpha1.img.xz">openEuler 20.03 LTS alpha1</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog.en.md">Link</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2020/10/27</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>224 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90-2009.3.0.0003</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.09-raspi-aarch64-alpha1.img.xz">openEuler 20.09 alpha1</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-20.09.en.md">Link</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2020/10/27</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>238 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.140-2009.4.0.0001</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.09/generic.repo">openEuler 20.09 repository built daily</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.09-desktop-raspi-aarch64-alpha1.img.xz">openEuler 20.09 alpha1 (with desktop environment)</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root (openeuler)</li><li>pi (raspberry)</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-20.09-desktop.en.md">Link</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2020/10/27</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>875 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.138-2008.1.0.0001</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-20.09/">openEuler 20.09 repository</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-20.09/raspi_img/aarch64/openEuler-20.09-raspi-aarch64.img.xz">openEuler 20.09</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>root (openeuler)</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-20.09-release.en.md">Link</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2020/09/30</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>259 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.138-2008.1.0.0001</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-20.09/">openEuler 20.09 repository</a></td>
</tr></tbody></table>

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
>Only openEuler 20.09 is supported currently.
>When building an image with Xfce desktop environment, you need to pay attention to two issues:
>1. Need to add an additional repository, which is the information of `[Xfce]` in the description of the parameter `-r/--repo`. Note that this repository is a temporary source for test, and it is used to supplement the related software packages of Xfce missing from the repositories of openEuler.
>2. Need to set the parameter `-s/--spec` to `standard` or `full`. Please refer to the description of this parameter for details.

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

    - The URL of target repo file: *currently unavailable*
    - The path of target repo file: `./openEuler-20.09.repo`

        The content of the repo file is as follows:

        ```
        [OS]
        name=OS
        baseurl=http://repo.openeuler.org/openEuler-20.09/OS/$basearch/
        enabled=1
        gpgcheck=1
        gpgkey=http://repo.openeuler.org/openEuler-20.09/OS/$basearch/RPM-GPG-KEY-openEuler

        [everything]
        name=everything
        baseurl=http://repo.openeuler.org/openEuler-20.09/everything/$basearch/
        enabled=1
        gpgcheck=1
        gpgkey=http://repo.openeuler.org/openEuler-20.09/everything/$basearch/RPM-GPG-KEY-openEuler

        [EPOL]
        name=EPOL
        baseurl=http://repo.openeuler.org/openEuler-20.09/EPOL/$basearch/
        enabled=1
        gpgcheck=1
        gpgkey=http://repo.openeuler.org/openEuler-20.09/EPOL/$basearch/RPM-GPG-KEY-openEuler

        [debuginfo]
        name=debuginfo
        baseurl=http://repo.openeuler.org/openEuler-20.09/debuginfo/$basearch/
        enabled=1
        gpgcheck=1
        gpgkey=http://repo.openeuler.org/openEuler-20.09/debuginfo/$basearch/RPM-GPG-KEY-openEuler

        [source]
        name=source
        baseurl=http://repo.openeuler.org/openEuler-20.09/source/
        enabled=1
        gpgcheck=1
        gpgkey=http://repo.openeuler.org/openEuler-20.09/source/RPM-GPG-KEY-openEuler

        [Xfce]
        name=Xfce
        baseurl=https://eulixos.com/repo/others/openeuler-raspberrypi/pkgs/
        enabled=1
        gpgcheck=0
        ```
    - List of repo's baseurls: `"http://repo.openeuler.org/openEuler-20.09/everything/aarch64/ http://repo.openeuler.org/openEuler-20.09/EPOL/aarch64/ https://eulixos.com/repo/others/openeuler-raspberrypi/pkgs/"`

3.  -n, --name IMAGE_NAME

    The image name to be built.

    For example, `openEuler-20.09.img`. The default is `openEuler-aarch64-raspi.img`, or it is automatically generated based on parameter: `-r, --repo REPO_INFO`.

4.  -s, --spec SPEC

    Specify the image version:
    - `headless`, image without desktop environments.
    - `standard`, image with Xfce desktop environment and fundamental softwares without CJK fonts and IME.
    - `full`, image with Xfce desktop environment and related softwares including CJK fonts and IME.

    The default is `headless`.

5.  -h, --help

    Display help information.

#### Build with kernel compilation

Here, we provide two approaches to build an image, which both include compiling kernel and downloading firmware files of Raspberry Pi. These approaches will take considerably longer.

>![](documents/public_sys-resources/icon-notice.gif) **NOTICE:**  
>Both openEuler 20.03 LTS and openEuler 20.09 are supported currently.
>When building an image with Xfce desktop environment, you need to pay attention to three issues:
>1. Only openEuler 20.09 is supported currently. Need to select the branch `openEuler-20.09` of the kernel source repository, i.e., setting the parameter `-b/--branch` to `openEuler-20.09`.
>2. Need to add an additional repository, which is the information of `[Xfce]` in the description of the parameter `-r/--repo`. Note that this repository is a temporary source for test, and it is used to supplement the related software packages of Xfce missing from the repositories of openEuler.
>3. Need to set the parameter `-s/--spec` to `standard` or `full`. Please refer to the description of this parameter for details.

##### Build on host

Run the following command to build an image:

`sudo bash build-image-common.sh -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO -s SPEC --cores N`

The meaning of each parameter:

1.  -n, --name IMAGE_NAME

    The image name to be built.

    For example, `openEuler-20.03-LTS.img`. The default is `openEuler-aarch64-raspi.img`, or it is automatically generated based on parameter: `-r, --repo REPO_INFO`.

2.  -k, --kernel KERNEL_URL

    The URL of kernel source repository, which defaults to `https://gitee.com/openeuler/raspberrypi-kernel.git`.

3.  -b, --branch KERNEL_BRANCH

    The branch name of kernel source repository, which defaults to `master`. `openEuler-20.03-LTS` or `openEuler-20.09` is recommended.

4.  -c, --config KERNEL_DEFCONFIG

    The filename/path of configuration for compiling kernel, which defaults to `openeuler-raspi_defconfig`. If this parameter is the filename of configuration, please make sure the configuration file in arch/arm64/configs of the kernel source.

5.  -r, --repo REPO_INFO

    The URL/path of target repo file, or the list of repositories' baseurls. Note that, the baseurls should be separated by space and enclosed in double quotes.

    Examples are as follows:

    - The URL of target repo file: `https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo`
    - The path of target repo file:

        - `./openEuler-20.03-LTS.repo`: to build openEuler 20.03 LTS image, refer to `https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo` for details about the content of the repo file.
        - `./openEuler-20.09.repo`: to build openEuler 20.09 image, the content of the repo file is as follows:

            ```
            [OS]
            name=OS
            baseurl=http://repo.openeuler.org/openEuler-20.09/OS/$basearch/
            enabled=1
            gpgcheck=1
            gpgkey=http://repo.openeuler.org/openEuler-20.09/OS/$basearch/RPM-GPG-KEY-openEuler

            [everything]
            name=everything
            baseurl=http://repo.openeuler.org/openEuler-20.09/everything/$basearch/
            enabled=1
            gpgcheck=1
            gpgkey=http://repo.openeuler.org/openEuler-20.09/everything/$basearch/RPM-GPG-KEY-openEuler

            [EPOL]
            name=EPOL
            baseurl=http://repo.openeuler.org/openEuler-20.09/EPOL/$basearch/
            enabled=1
            gpgcheck=1
            gpgkey=http://repo.openeuler.org/openEuler-20.09/EPOL/$basearch/RPM-GPG-KEY-openEuler

            [debuginfo]
            name=debuginfo
            baseurl=http://repo.openeuler.org/openEuler-20.09/debuginfo/$basearch/
            enabled=1
            gpgcheck=1
            gpgkey=http://repo.openeuler.org/openEuler-20.09/debuginfo/$basearch/RPM-GPG-KEY-openEuler

            [source]
            name=source
            baseurl=http://repo.openeuler.org/openEuler-20.09/source/
            enabled=1
            gpgcheck=1
            gpgkey=http://repo.openeuler.org/openEuler-20.09/source/RPM-GPG-KEY-openEuler

            [Xfce]
            name=Xfce
            baseurl=https://eulixos.com/repo/others/openeuler-raspberrypi/pkgs/
            enabled=1
            gpgcheck=0
            ```
    - List of repo's baseurls: `"http://repo.openeuler.org/openEuler-20.03-LTS/OS/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/EPOL/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/source"` or `"http://repo.openeuler.org/openEuler-20.09/everything/aarch64/ http://repo.openeuler.org/openEuler-20.09/EPOL/aarch64/ https://eulixos.com/repo/others/openeuler-raspberrypi/pkgs/"`

6.  -s, --spec SPEC

    Specify the image version:
    - `headless`, image without desktop environments.
    - `standard`, image with Xfce desktop environment and fundamental softwares without CJK fonts and IME.
    - `full`, image with Xfce desktop environment and related softwares including CJK fonts and IME.

    The default is `headless`.

7.  --cores N

    The number of parallel compilations, according to the actual number of CPU of the host running the script. The default is the number of processing units available.

##### Build in a Docker container

Run the following command to build an image:

`sudo bash build-image-docker.sh -d DOCKER_FILE -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO --cores N`

Caution, before running the script, you need to install Docker. The script will automatically import the Docker image into the local system according to the script's parameter: DOCKER_FILE.

In addition to the parameter DOCKER_FILE, the other parameters are the same as the corresponding parameters in [Build on host](#Build-on-host):

1.  -d, --docker DOCKER_FILE

    The URL/path of the Docker image, which defaults to `https://repo.openeuler.org/openEuler-20.03-LTS/docker_img/aarch64/openEuler-docker.aarch64.tar.xz`. With the default parameter, the script will automatically download the Docker image of openEuler 20.03 LTS and import it into the local system.
