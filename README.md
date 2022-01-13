# raspberrypi

[English](./README.en.md) | 简体中文

本仓库是 openEuler 社区树莓派 SIG 组的主仓库，提供 SIG 组相关信息以及适用于树莓派的 openEuler 镜像的构建脚本和相关文档。

此外，树莓派 SIG 还致力于将 openEuler 移植到其他开发板，例如 [Rockchip](https://gitee.com/openeuler/rockchip)。

<!-- TOC -->

- [raspberrypi](#raspberrypi)
    - [如何参与 SIG 组](#如何参与-sig-组)
    - [文件说明](#文件说明)
    - [最新镜像](#最新镜像)
    - [使用镜像](#使用镜像)
    - [镜像构建](#镜像构建)
        - [准备环境](#准备环境)
        - [构建镜像](#构建镜像)
            - [快速构建（无需编译内核，推荐）](#快速构建无需编译内核推荐)
            - [完全构建（包括编译内核）](#完全构建包括编译内核)
                - [主机上构建](#主机上构建)
                - [Docker 容器内构建](#docker-容器内构建)

<!-- /TOC -->

## 如何参与 SIG 组

SIG 组基本信息位于 [sig-RaspberryPi](https://gitee.com/openeuler/community/tree/master/sig/sig-RaspberryPi)。

- 建立或回复 issue：欢迎通过建立或回复 issue 来讨论，此 SIG 组维护的仓库列表可在 [sig-RaspberryPi](https://gitee.com/openeuler/community/tree/master/sig/sig-RaspberryPi) 中查看。
- 加入 Slack 群组：[openeuler-raspberrypi](https://openeuler-raspberrypi.slack.com )
  - [加入群组链接](https://join.slack.com/t/openeuler-raspberrypi/shared_invite/zt-uh95ug4n-yX7a~c7VrTEU64tZlX3Djw)
- SIG 组会议：每个月的第一个和第三个周三下午 17:00 - 17:30 会进行一次讨论会议
  - 会议链接：有以下两种获取方式
    - [openEuler 社区网站](https://openeuler.org/)下的会议日历中查看 `sig-RaspberryPi例会` 预定信息。
    - 微信小程序搜索 `openEuler`，添加 `openEuler` 小程序，可在其`会议`栏目查看 `sig-RaspberryPi例会` 预定信息。
  - [会议议题](https://etherpad.openeuler.org/p/sig-RaspberryPi-meetings)：每次会议前填写要讨论的议题，我们也会从 issue 列表中提取本周讨论的内容。
  - [会议记录](https://gitee.com/openeuler/raspberrypi/issues/I1EYZ6)：每次会议结束后会议结论会更新在此 issue 中。
- 重要的事说三遍：**欢迎提交 PR！欢迎提交 PR！欢迎提交 PR！**

## 文件说明

>![](documents/public_sys-resources/icon-note.gif) **说明：**   
>- 建议直接使用本文档 [最新镜像](#最新镜像) 章节中给出的 openEuler 的树莓派镜像。
>- 如需根据自身需求定制镜像，可参考 [openEuler 镜像的构建](documents/openEuler镜像的构建.md) 和 [交叉编译内核](documents/交叉编译内核.md)。

- [documents](./documents/): 使用文档
  - [刷写镜像](documents/刷写镜像.md)
  - [树莓派使用](documents/树莓派使用.md)
  - [openEuler 镜像的构建](documents/openEuler镜像的构建.md)
  - [交叉编译内核](documents/交叉编译内核.md)
  - [QEMU 启动树莓派](documents/QEMU启动树莓派.md)
  - [openEuler 20.03 LTS SP2 更新日志](documents/changelog/changelog-20.03-LTS-SP2.md)
  - [openEuler 20.03 LTS SP2 内测版（UKUI 桌面、中文输入法）更新日志](documents/changelog/changelog-20.03-LTS-SP2-UKUI.md)
  - [openEuler 20.03 LTS SP2 内测版（DDE 桌面、中文输入法）更新日志](documents/changelog/changelog-20.03-LTS-SP2-DDE.md)
  - [openEuler 20.03 LTS SP2 内测版（Xfce 桌面、中文输入法）更新日志](documents/changelog/changelog-20.03-LTS-SP2-Xfce.md)
  - [openEuler 21.09 更新日志](documents/changelog/changelog-21.09.md)
  - [openEuler 21.09 内测版（UKUI 桌面、中文输入法）更新日志](documents/changelog/changelog-21.09-UKUI.md)
  - [openEuler 21.09 内测版（DDE 桌面、中文输入法）更新日志](documents/changelog/changelog-21.09-DDE.md)
  - [openEuler 21.09 内测版（Xfce 桌面、中文输入法）更新日志](documents/changelog/changelog-21.09-Xfce.md)
  - [openEuler 21.09 内测版（LXDE 桌面、中文输入法）更新日志](documents/changelog/changelog-21.09-LXDE.md)
- [scripts](./scripts): 构建 openEuler 树莓派镜像的脚本
  - [快速构建（不编译内核）](scripts/build-image.sh)
  - [主机上构建（编译内核）](scripts/build-image-common.sh)
  - [Docker 容器中构建（编译内核）](scripts/build-image-docker.sh)

## 最新镜像

镜像的基本信息如下所示。[更多镜像](documents/images.md)

<table><thead align="left"><tr>
<th class="cellrowborder" valign="top" width="10%"><p><strong>镜像版本</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>系统用户（密码）</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>更新日志</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>发布时间</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>大小</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>内核版本</strong></p></th>
<th class="cellrowborder" valign="top" width="10%"><p><strong>构建文件系统的源仓库</strong></p></th>
</tr></thead>
<tbody>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.03-LTS-SP3-raspi-aarch64-alpha1.img.xz">openEuler 20.03 LTS SP3 内测版</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>-</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2022/01/07</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>234 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90-2112.6.0.0037</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/20.03:/LTS:/SP3/standard_aarch64/aarch64/">openEuler 20.03 LTS SP3 每日构建源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.03-LTS-SP3-UKUI-raspi-aarch64-alpha1.img.xz">openEuler 20.03 LTS SP3 内测版（UKUI 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>-</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2022/01/07</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.1 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90-2112.6.0.0037</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/20.03:/LTS:/SP3/standard_aarch64/aarch64/">openEuler 20.03 LTS SP3 每日构建源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.03-LTS-SP3-DDE-raspi-aarch64-alpha1.img.xz">openEuler 20.03 LTS SP3 内测版（DDE 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>-</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2022/01/07</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.4 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90-2112.6.0.0037</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/20.03:/LTS:/SP3/standard_aarch64/aarch64/">openEuler 20.03 LTS SP3 每日构建源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-20.03-LTS-SP3-Xfce-raspi-aarch64-alpha1.img.xz">openEuler 20.03 LTS SP3 内测版（Xfce 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><p>-</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2022/01/07</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.8 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90-2112.6.0.0037</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/20.03:/LTS:/SP3/standard_aarch64/aarch64/">openEuler 20.03 LTS SP3 每日构建源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-20.03-LTS-SP3/raspi_img/openEuler-20.03-LTS-SP3-raspi-aarch64.img.xz">openEuler 20.03 LTS SP3</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>root（openeuler）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>-</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2022/01/01</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>259 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>4.19.90-2112.6.0.0037</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS-SP3/generic.repo">openEuler 20.03 LTS SP3 源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-21.09-raspi-aarch64-alpha2.img.xz">openEuler 21.09 内测版</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-21.09.md">更新日志</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2022/01/07</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>241 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-5.10.0.8</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/21.09/standard_aarch64/aarch64/">openEuler 21.09 每日构建源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-21.09-UKUI-raspi-aarch64-alpha2.img.xz">openEuler 21.09 内测版（UKUI 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-21.09-UKUI.md">更新日志</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2022/01/07</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.3 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-5.10.0.8</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/21.09/standard_aarch64/aarch64/">openEuler 21.09 每日构建源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-21.09-DDE-raspi-aarch64-alpha2.img.xz">openEuler 21.09 内测版（DDE 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-21.09-DDE.md">更新日志</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2022/01/13</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.2 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-5.10.0.8</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/21.09/standard_aarch64/aarch64/">openEuler 21.09 每日构建源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-21.09-Xfce-raspi-aarch64-alpha2.img.xz">openEuler 21.09 内测版（Xfce 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-21.09-Xfce.md">更新日志</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2022/01/07</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>1.9 GiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-5.10.0.8</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/21.09/standard_aarch64/aarch64/">openEuler 21.09 每日构建源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://isrc.iscas.ac.cn/eulixos/repo/others/openeuler-raspberrypi/images/openEuler-21.09-LXDE-raspi-aarch64-alpha2.img.xz">openEuler 21.09 内测版（LXDE 桌面、中文输入法）</a></td>
<td class="cellrowborder" valign="top" width="10%"><ul><li>root（openeuler）</li><li>pi（raspberry）</li></ul></td>
<td class="cellrowborder" valign="top" width="10%"><a href="documents/changelog/changelog-21.09-LXDE.md">更新日志</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>2022/01/07</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>548 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-5.10.0.8</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="http://119.3.219.20:82/openEuler:/21.09/standard_aarch64/aarch64/">openEuler 21.09 每日构建源仓库</a></td>
</tr>
<tr>
<td class="cellrowborder" valign="top" width="10%"><a href="https://repo.openeuler.org/openEuler-21.09/raspi_img/openEuler-21.09-raspi-aarch64.img.xz">openEuler 21.09</a></td>
<td class="cellrowborder" valign="top" width="10%"><p>root（openeuler）</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>-</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>2021/09/30</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>243 MiB</p></td>
<td class="cellrowborder" valign="top" width="10%"><p>5.10.0-5.10.0.8</p></td>
<td class="cellrowborder" valign="top" width="10%"><a href="https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-21.09/generic.repo">openEuler 21.09 源仓库</a></td>
</tr>
</tbody></table>

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
>当前支持三个 openEuler 版本，即 20.09、20.03 LTS SP1、21.03、20.03 LTS SP2、21.09、20.03 LTS SP3 版本。
>如果构建包含 Xfce/UKUI/DDE 桌面环境的镜像，需要注意三点：
>1. 构建包含 Xfce 桌面环境的镜像，当前只支持 openEuler 21.03/20.03 LTS SP2/21.09/20.03 LTS SP3 版本。
>2. 构建包含 DDE 桌面环境的镜像，当前只支持 openEuler 20.03 LTS SP1/21.03/20.03 LTS SP2/21.09/20.03 LTS SP3 版本。
>3. 根据需要设置 -s/--spec，其具体意义见该参数的介绍部分。

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
    - 开发源 repo 文件的 URL，如 `https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-21.03/generic.repo`。
    - 开发源的 repo 文件路径：
        - `./openEuler-21.03.repo`：生成 openEuler 21.03 版本的镜像，该文件内容参考 <https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-21.03/generic.repo>。
    - 资源库的 baseurl 列表，如 `"http://repo.openeuler.org/openEuler-21.03/OS/aarch64/ http://repo.openeuler.org/openEuler-21.03/EPOL/aarch64/"`。

3.  -n, --name IMAGE_NAME

    构建的镜像名称。

    例如，`openEuler-21.03.img`。默认为`openEuler-raspi-aarch64.img`，或者根据 `-n, --name IMAGE_NAME` 参数自动生成。

4.  -s, --spec SPEC

    构建的镜像版本：
    - `headless`，无图形界面版的镜像。
    - `xfce`，带 Xfce 桌面以及中文字体、输入法等全部配套软件。
    - `ukui`，带 UKUI 桌面及必要的配套软件（不包括中文字体以及输入法）。
    - `dde`，带 DDE 桌面及必要的配套软件（不包括中文字体以及输入法）。
    -  rpmlist 文件路径，其中包含镜像中要安装的软件列表，内容参考 [rpmlist](./scripts/config/rpmlist)。

    默认使用 `headless` 选项。

5.  -h, --help

    显示帮助信息。

#### 完全构建（包括编译内核）

包含编译内核、下载树莓派相关固件等过程，速度相对较慢。

这里，提供两种构建方式。

>![](documents/public_sys-resources/icon-notice.gif) **须知：**  
>当前支持三个 openEuler 版本，即 20.03 LTS、20.09、20.03 LTS SP1、21.03、20.03 LTS SP2、21.09、20.03 LTS SP3 版本。
>如果构建包含 Xfce/UKUI/DDE 桌面环境的镜像，需要注意四点：
>1. 构建包含 Xfce 桌面环境的镜像，当前只支持 openEuler 21.03/20.03 LTS SP2/21.09/20.03 LTS SP3 版本，需要选择对应内核源码和分支。
>    -  openEuler 21.03：需要选择 [openEuler 内核](https://gitee.com/openeuler/kernel) 的 [openEuler-21.03](https://gitee.com/openeuler/kernel/tree/openEuler-21.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@gitee.com:openeuler/kernel.git`，-b/--branch` 设置为 `openEuler-21.03`。
>    -  openEuler 20.03 LTS SP2/20.03 LTS SP3：需要选择 [openEuler-RaspberryPi 内核](https://gitee.com/openeuler/raspberrypi-kernel) 的 [openEuler-20.03-LTS](https://gitee.com/openeuler/raspberrypi-kernel/tree/openEuler-20.03-LTS/) 分支，即将参数 `-k/--kernel` 设置为 `git@gitee.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-20.03-LTS`。
>    -  openEuler 21.09：需要选择 [openEuler-RaspberryPi 内核](https://gitee.com/openeuler/raspberrypi-kernel) 的 [openEuler-21.09](https://gitee.com/openeuler/raspberrypi-kernel/tree/openEuler-21.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@gitee.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-21.09`。
>2. 构建包含 UKUI 桌面环境的镜像，当前只支持 openEuler 20.09/20.03 LTS SP1/21.03/20.03 LTS SP2/21.09/20.03 LTS SP3 版本，需要选择对应内核源码和分支。
>    -  openEuler 20.09：需要选择 [openEuler-RaspberryPi 内核](https://gitee.com/openeuler/raspberrypi-kernel) 的 [openEuler-20.09](https://gitee.com/openeuler/raspberrypi-kernel/tree/openEuler-20.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@gitee.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-20.09`。
>    -  openEuler 20.03 LTS SP1/20.03 LTS SP2/20.03 LTS SP3：需要选择 [openEuler-RaspberryPi 内核](https://gitee.com/openeuler/raspberrypi-kernel) 的 [openEuler-20.03-LTS](https://gitee.com/openeuler/raspberrypi-kernel/tree/openEuler-20.03-LTS/) 分支，即将参数 `-k/--kernel` 设置为 `git@gitee.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-20.03-LTS`。
>    -  openEuler 21.03：需要选择 [openEuler 内核](https://gitee.com/openeuler/kernel) 的 [openEuler-21.03](https://gitee.com/openeuler/kernel/tree/openEuler-21.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@gitee.com:openeuler/kernel.git`，-b/--branch` 设置为 `openEuler-21.03`。
>    -  openEuler 21.09：需要选择 [openEuler-RaspberryPi 内核](https://gitee.com/openeuler/raspberrypi-kernel) 的 [openEuler-21.09](https://gitee.com/openeuler/raspberrypi-kernel/tree/openEuler-21.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@gitee.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-21.09`。
>3. 构建包含 DDE 桌面环境的镜像，当前只支持 openEuler 20.03 LTS SP1/21.03/20.03 LTS SP2/21.09/20.03 LTS SP3 版本。
>    -  openEuler 20.03 LTS SP1/20.03 LTS SP2/20.03 LTS SP3：需要选择 [openEuler-RaspberryPi 内核](https://gitee.com/openeuler/raspberrypi-kernel) 的 [openEuler-20.03-LTS](https://gitee.com/openeuler/raspberrypi-kernel/tree/openEuler-20.03-LTS/) 分支，即将参数 `-k/--kernel` 设置为 `git@gitee.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-20.03-LTS`。
>    -  openEuler 21.03：需要选择 [openEuler 内核](https://gitee.com/openeuler/kernel) 的 [openEuler-21.03](https://gitee.com/openeuler/kernel/tree/openEuler-21.03/) 分支，即将参数 `-k/--kernel` 设置为 `git@gitee.com:openeuler/kernel.git`，-b/--branch` 设置为 `openEuler-21.03`。
>    -  openEuler 21.09：需要选择 [openEuler-RaspberryPi 内核](https://gitee.com/openeuler/raspberrypi-kernel) 的 [openEuler-21.09](https://gitee.com/openeuler/raspberrypi-kernel/tree/openEuler-21.09/) 分支，即将参数 `-k/--kernel` 设置为 `git@gitee.com:openeuler/raspberrypi-kernel.git`，`-b/--branch` 设置为 `openEuler-21.09`。
>4. 根据需要设置 -s/--spec，其具体意义见该参数的介绍部分。

##### 主机上构建

构建镜像需执行命令：

`sudo bash build-image-common.sh -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO -s SPEC --cores N`

脚本运行结束后，会提示镜像的存储位置，镜像默认保存在脚本运行所在目录的 `raspi_output_common/img/` 下。

各个参数意义：

1.  -n, --name IMAGE_NAME

    构建的镜像名称。

    例如，`openEuler-20.03-LTS-SP1.img`。默认为`openEuler-raspi-aarch64.img`，或者根据 `-n, --name IMAGE_NAME` 参数自动生成。

2.  -k, --kernel KERNEL_URL

    内核源码仓库的项目地址，默认为 `https://gitee.com/openeuler/raspberrypi-kernel.git`。可根据需要设置为 `git@gitee.com:openeuler/raspberrypi-kernel.git` 或 `git@gitee.com:openeuler/kernel.git`。

3.  -b, --branch KERNEL_BRANCH

    内核源码的对应分支，默认为 `openEuler-20.03-LTS`，推荐使用分支 `openEuler-21.09`、`openEuler-20.03-LTS` 或 `openEuler-20.09`。

4.  -c, --config KERNEL_DEFCONFIG

    内核编译使用的配置文件名称或路径，默认为 `openeuler-raspi_defconfig`。如果该参数为配置文件名称，请确保该文件在内核源码的目录 arch/arm64/configs 下。

5.  -r, --repo REPO_INFO

    开发源 repo 文件的 URL 或者路径，也可以是开发源中资源库的 baseurl 列表。注意，如果该参数为资源库的 baseurl 列表，该参数需要使用双引号，各个 baseurl 之间以空格隔开。

    下面分别举例：
    - 开发源 repo 文件的 URL，如 `https://gitee.com/src-openeuler/openEuler-repos/raw/openEuler-20.03-LTS-SP1/generic.repo`
    - 开发源的 repo 文件路径：
        - `./openEuler-20.03-LTS-SP1.repo`：生成 openEuler 20.03 LTS SP1 版本的镜像，该文件内容参考 <https://gitee.com/src-openeuler/openEuler-repos/blob/openEuler-20.03-LTS-SP1/generic.repo>。
    - 资源库的 baseurl 列表，如 `"http://repo.openeuler.org/openEuler-20.03-LTS-SP1/OS/aarch64/ http://repo.openeuler.org/openEuler-20.03-LTS-SP1/EPOL/aarch64/"`。

6.  -s, --spec SPEC

    构建的镜像版本：
    - `headless`，无图形界面版的镜像。
    - `xfce`，带 Xfce 桌面以及中文字体、输入法等全部配套软件。
    - `ukui`，带 UKUI 桌面及必要的配套软件（不包括中文字体以及输入法）。
    - `dde`，带 DDE 桌面及必要的配套软件（不包括中文字体以及输入法）。
    -  rpmlist 文件路径，该文件包含镜像中要安装的软件列表，内容参考 [rpmlist](./scripts/config-common/rpmlist)。

    默认使用 `headless` 选项。

7.  --cores N

    并行编译的数量，根据运行脚本的宿主机 CPU 实际数目设定，默认为可用的 CPU 总数。

##### Docker 容器内构建

构建镜像需执行命令：

`sudo bash build-image-docker.sh -d DOCKER_FILE -n IMAGE_NAME -k KERNEL_URL -b KERNEL_BRANCH -c KERNEL_DEFCONFIG -r REPO --cores N`

脚本运行结束后，镜像默认保存在脚本运行所在目录的 `raspi_output_common/img/` 下。

注意！！！运行该脚本前，需安装 Docker 运行环境。该脚本会自动将 DOCKER_FILE 参数对应的 Docker 镜像导入本机系统中。

除参数 DOCKER_FILE 外，剩余参数与[主机上构建](#主机上构建)中对应参数一致：

1.  -d, --docker DOCKER_FILE

    Docker 镜像的 URL 或者路径， 默认为 `https://repo.openeuler.org/openEuler-20.03-LTS-SP1/docker_img/aarch64/openEuler-docker.aarch64.tar.xz`。使用该默认参数时，脚本会自动下载 openEuler 20.03 LTS SP1 的 Docker 镜像，并导入本机系统中。
