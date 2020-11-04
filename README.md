# raspberrypi

[English](./README.en.md) | 简体中文

本仓库是 openEuler 社区树莓派 SIG 组的主仓库，提供 SIG 组相关信息以及适用于树莓派的 openEuler 镜像的构建脚本和相关文档：

## 如何参与 SIG 组

SIG 组基本信息位于 [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi)。

- 建立或回复 issue：欢迎通过建立或回复 issue 来讨论，此 SIG 组维护的仓库列表可在 [sig-RaspberryPi](https://gitee.com/jianminw/community/tree/master/sig/sig-RaspberryPi) 中查看。
- 加入 Slack 群组：[openeuler-raspberrypi](https://openeuler-raspberrypi.slack.com )
  - [加入群组链接](https://join.slack.com/t/openeuler-raspberrypi/shared_invite/zt-iqpnvura-TiEGGioYPC6gswmhWrIisQ)，此链接于 2020/12/04 失效，我们会定期更新。
- SIG 组会议：每个月的第一个和第三个周二下午 03:00 - 03:30 会进行一次讨论会议
  - 会议链接：有以下两种获取方式
    - [openEuler 社区网站](https://openeuler.org/)下的会议日历中查看 `sig-RaspberryPi例会` 预定信息。
    - 微信小程序搜索 `openEuler`，添加 `openEuler` 小程序，可在其`会议`栏目查看 `sig-RaspberryPi例会` 预定信息。
  - [会议议题](https://etherpad.openeuler.org/p/sig-RaspberryPi-meetings)：每次会议前填写要讨论的议题，我们也会从 issue 列表中提取本周讨论的内容。
  - [会议记录](https://gitee.com/openeuler/raspberrypi/issues/I1EYZ6)：每次会议结束后会议结论会更新在此 issue 中。
- 重要的事说三遍：**欢迎提交 PR！欢迎提交 PR！欢迎提交 PR！**

## 仓库目录

- [scripts](./scripts): 构建 openEuler 树莓派镜像的脚本
  - [快速构建（不编译内核）](scripts/build-image.sh)
  - [主机上构建（编译内核）](scripts/build-image-common.sh)
  - [Docker 容器中构建（编译内核）](scripts/build-image-docker.sh)
- [documents](./documents/): 使用文档
  - [openEuler 镜像的构建](documents/openEuler镜像的构建.md)
  - [交叉编译内核](documents/交叉编译内核.md)
  - [刷写镜像](documents/刷写镜像.md)
  - [树莓派使用](documents/树莓派使用.md)
  - [openEuler 20.03 LTS 内测版更新日志](documents/changelog/changelog.md)
  - [openEuler 20.09 内测版更新日志](documents/changelog/changelog-20.09.md)
  - [openEuler 20.09 内测版（含 Xfce 桌面环境）更新日志](documents/changelog/changelog-20.09-desktop.md)
  - [openEuler 20.09 更新日志](documents/changelog/changelog-20.09-release.md)

## 最新镜像

镜像的基本信息如下所示：

<table><thead align="left"><tr>
<th class="cellrowborder" valign="top" width="10%"><p><strong>镜像版本</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>系统用户（密码）</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>更新日志</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>发布时间</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>大小</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>内核版本</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>构建文件系统的源仓库</strong></p></th>
</tr></thead>
<tbody><tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.03-LTS-raspi-aarch64-alpha1.img.xz">openEuler 20.03 LTS 内测版</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog.md">链接</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2020/10/27</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>224 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90-2009.3.0.0003</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo">openEuler 20.03 LTS 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.09-raspi-aarch64-alpha1.img.xz">openEuler 20.09 内测版</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-20.09.md">链接</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2020/10/27</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>238 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.140-2009.4.0.0001</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.09/generic.repo">openEuler 20.09 每日构建源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.09-desktop-raspi-aarch64-alpha1.img.xz">openEuler 20.09 内测版（包含 Xfce 桌面环境）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-20.09-desktop.md">链接</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2020/10/27</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>875 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.138-2008.1.0.0001</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-20.09">openEuler 20.09 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-20.09/raspi_img/aarch64/openEuler-20.09-raspi-aarch64.img.xz">openEuler 20.09</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>root（openeuler）</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-20.09-release.md">链接</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2020/09/30</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>259 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.138-2008.1.0.0001</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-20.09/">openEuler 20.09 源仓库</a></td>
</tr></tbody></table>

其他信息：
- 固件来源：[firmware](https://github.com/raspberrypi/firmware)、[bluez-firmware](https://github.com/RPi-Distro/bluez-firmware)、[firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree)

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

>![](documents/public_sys-resources/icon-notice.gif) **须知：**  
>当前只支持 openEuler 20.09 版本。
>如果构建包含 Xfce 桌面环境的镜像，需要注意两点：
>1. 需要添加额外的开发源，也就是下面 `-r/--repo` 参数介绍中 `[Xfce]` 对应的信息。注意，该开发源是临时的测试源，其目的为补充 openEuler 的开发源中缺失的 Xfce 相关软件包。
>2. 根据需要设置 `-s/--spec` 为 `standard` 或 `full`，其具体意义见该参数的介绍部分。

使用已有的树莓派内核、固件、蓝牙等 RPM 包构建镜像。

构建镜像需执行命令：

`sudo bash build-image.sh -d DIR -r REPO -n IMAGE_NAME -s SPEC`

各个参数意义：

1.  -d, --dir DIR

    构建镜像和临时文件的输出目录，默认为脚本所在目录。如果 `DIR` 不存在则会自动创建。

    脚本运行结束后，会提示镜像的存储位置，默认保存在 `DIR/raspi_output/img/` 下。

2.  -r, --repo REPO_INFO

    开发源 repo 文件的 URL 或者路径，也可以是开发源中资源库的 baseurl 列表。注意，如果该参数为资源库的 baseurl 列表，该参数需要使用双引号，各个 baseurl 之间以空格隔开。

    下面分别举例：
    - 开发源 repo 文件的 URL：*暂无*
    - 开发源的 repo 文件路径：`./openEuler-20.09.repo`

        该文件的内容如下：

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
    - 资源库的 baseurl 列表：`"http://repo.openeuler.org/openEuler-20.09/everything/aarch64/ http://repo.openeuler.org/openEuler-20.09/EPOL/aarch64/ https://eulixos.com/repo/others/openeuler-raspberrypi/pkgs/"`

3.  -n, --name IMAGE_NAME

    构建的镜像名称。

    例如，`openEuler-20.09.img`。默认为`openEuler-raspi-aarch64.img`，或者根据 `-n, --name IMAGE_NAME` 参数自动生成。

4.  -s, --spec SPEC

    构建的镜像版本：
    - `headless`，无图形界面版的镜像。
    - `standard`，带 Xfce 桌面及必要的配套软件（不包括中文字体以及输入法）。
    - `full`，带 Xfce 桌面以及中文字体、输入法等全部配套软件。

    默认使用 `headless` 选项。

5.  -h, --help

    显示帮助信息。

#### 完全构建（包括编译内核）

包含编译内核、下载树莓派相关固件等过程，速度相对较慢。

这里，提供两种构建方式。

>![](documents/public_sys-resources/icon-notice.gif) **须知：**  
>当前支持 openEuler 20.03 LTS 或 openEuler 20.09 版本。
>如果构建包含 Xfce 桌面环境的镜像，需要注意三点：
>1. 只支持 openEuler 20.09 版本。需要选择内核源码的 `openEuler-20.09` 分支，即参数 `-b/--branch` 设置为 `openEuler-20.09`。
>2. 需要添加额外的开发源，也就是下面 `-r/--repo` 参数介绍中 `[Xfce]` 对应的信息。注意，该开发源是临时的测试源，其目的为补充 openEuler 的开发源中缺失的 Xfce 相关软件包。
>3. 根据需要设置 `-s/--spec` 为 `standard` 或 `full`，其具体意义见该参数的介绍部分。

##### 主机上构建

构建镜像需执行命令：

`sudo bash build-image-common.sh -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO -s SPEC --cores N`

各个参数意义：

1.  -n, --name IMAGE_NAME

    构建的镜像名称。

    例如，`openEuler-20.03-LTS.img`。默认为`openEuler-raspi-aarch64.img`，或者根据 `-n, --name IMAGE_NAME` 参数自动生成。

2.  -k, --kernel KERNEL_URL

    内核源码仓库的项目地址，默认为 `https://gitee.com/openeuler/raspberrypi-kernel.git`。

3.  -b, --branch KERNEL_BRANCH

    内核源码的对应分支，默认为 `master`，推荐使用分支 `openEuler-20.03-LTS` 或 `openEuler-20.09`。

4.  -c, --config KERNEL_DEFCONFIG

    内核编译使用的配置文件名称或路径，默认为 `openeuler-raspi_defconfig`。如果该参数为配置文件名称，请确保该文件在内核源码的目录 arch/arm64/configs 下。

5.  -r, --repo REPO_INFO

    开发源 repo 文件的 URL 或者路径，也可以是开发源中资源库的 baseurl 列表。注意，如果该参数为资源库的 baseurl 列表，该参数需要使用双引号，各个 baseurl 之间以空格隔开。

    下面分别举例：
    - 开发源 repo 文件的 URL：`https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo`
    - 开发源的 repo 文件路径：

        - `./openEuler-20.03-LTS.repo`：生成 openEuler 20.03 LTS 版本的镜像，该文件内容参考 <https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS/generic.repo>。
        - `./openEuler-20.09.repo`：生成 openEuler 20.09 版本的镜像，该文件的内容如下：

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
    - 资源库的 baseurl 列表：`"http://repo.openeuler.org/openEuler-20.03-LTS/OS/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/EPOL/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS/source"` 或 `"http://repo.openeuler.org/openEuler-20.09/everything/aarch64/ http://repo.openeuler.org/openEuler-20.09/EPOL/aarch64/ https://eulixos.com/repo/others/openeuler-raspberrypi/pkgs/"`

6.  -s, --spec SPEC

    构建的镜像版本：
    - `headless`，无图形界面版的镜像。
    - `standard`，带 Xfce 桌面及必要的配套软件（不包括中文字体以及输入法）。
    - `full`，带 Xfce 桌面以及中文字体、输入法等全部配套软件。

    默认使用 `headless` 选项。

7.  --cores N

    并行编译的数量，根据运行脚本的宿主机 CPU 实际数目设定，默认为可用的 CPU 总数。

##### Docker 容器内构建

构建镜像需执行命令：

`sudo bash build-image-docker.sh -d DOCKER_FILE -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO --cores N`

注意！！！运行该脚本前，需安装 Docker 运行环境。该脚本会自动将 DOCKER_FILE 参数对应的 Docker 镜像导入本机系统中。

除参数 DOCKER_FILE 外，剩余参数与[主机上构建](#主机上构建)中对应参数一致：

1.  -d, --docker DOCKER_FILE

    Docker 镜像的 URL 或者路径， 默认为 `https://repo.openeuler.org/openEuler-20.03-LTS/docker_img/aarch64/openEuler-docker.aarch64.tar.xz`。使用该默认参数时，脚本会自动下载 openEuler 20.03 LTS 的 Docker 镜像，并导入本机系统中。
