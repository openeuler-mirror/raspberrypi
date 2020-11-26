#!/bin/bash
set -e

__usage="
Usage: build-image-common [OPTIONS]
Build raspberrypi image.

Options:
  -n, --name IMAGE_NAME            The raspberrypi image name to be built.
  -k, --kernel KERNEL_URL          The URL of kernel source's repository, which defaults to https://gitee.com/openeuler/raspberrypi-kernel.git.
  -b, --branch KERNEL_BRANCH       The branch name of kernel source's repository, which defaults to master.
  -c, --config KERNEL_DEFCONFIG    The name/path of defconfig file when compiling kernel, which defaults to openeuler-raspi_defconfig.
  -r, --repo REPO_INFO             Required! The URL/path of target repo file or list of repo's baseurls which should be a space separated list.
  -s, --spec SPEC                  The image's specification: headless, standard, full. The default is headless.
  --cores N                        The number of cpu cores to be used during making.
  -h, --help                       Show command help.
"

help()
{
    echo "$__usage"
    exit $1
}

parseargs()
{
    if [ "x$#" == "x0" ]; then
        return 1
    fi

    while [ "x$#" != "x0" ];
    do
        if [ "x$1" == "x-h" -o "x$1" == "x--help" ]; then
            return 1
        elif [ "x$1" == "x" ]; then
            shift
        elif [ "x$1" == "x-n" -o "x$1" == "x--name" ]; then
            img_name=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-k" -o "x$1" == "x--kernel" ]; then
            kernel_url=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-b" -o "x$1" == "x--branch" ]; then
            kernel_branch=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-c" -o "x$1" == "x--config" ]; then
            default_defconfig=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-r" -o "x$1" == "x--repo" ]; then
            repo_file=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-s" -o "x$1" == "x--spec" ]; then
            spec_param=`echo $2`
            shift
            shift
        elif [ "x$1" == "x--cores" ]; then
            make_cores=`echo $2`
            shift
            shift
        else
            echo `date` - ERROR, UNKNOWN params "$@"
            return 2
        fi
    done
}

ERROR(){
    echo `date` - ERROR, $* | tee -a ${log_dir}/${builddate}.log
}

LOG(){
    echo `date` - INFO, $* | tee -a ${log_dir}/${builddate}.log
}

UMOUNT_ALL(){
    set +e
    if grep -q "${rootfs_dir}/dev " /proc/mounts ; then
        umount -l ${rootfs_dir}/dev
    fi
    if grep -q "${rootfs_dir}/proc " /proc/mounts ; then
        umount -l ${rootfs_dir}/proc
    fi
    if grep -q "${rootfs_dir}/sys " /proc/mounts ; then
        umount -l ${rootfs_dir}/sys
    fi
    set -e
}

LOSETUP_D_IMG(){
    set +e
    if [ -d ${root_mnt} ]; then
        if grep -q "${root_mnt} " /proc/mounts ; then
            umount ${root_mnt}
        fi
    fi
    if [ -d ${boot_mnt} ]; then
        if grep -q "${boot_mnt} " /proc/mounts ; then
            umount ${boot_mnt}
        fi
    fi
    if [ "x$device" != "x" ]; then
        kpartx -d ${device}
        losetup -d ${device}
        device=""
    fi
    if [ -d ${root_mnt} ]; then
        rm -rf ${root_mnt}
    fi
    if [ -d ${boot_mnt} ]; then
        rm -rf ${boot_mnt}
    fi
    set -e
}

INSTALL_PACKAGES(){
    for item in $(cat $1)
    do
        dnf --installroot=${rootfs_dir}/ install -y $item
        if [ $? == 0 ]; then
            LOG install $item.
        else
            ERROR can not install $item.
        fi
    done
}

prepare(){
    if [ ! -d ${tmp_dir} ]; then
        mkdir -p ${tmp_dir}
    else
        rm -rf ${tmp_dir}/*
    fi

    kernel_name=${kernel_url##*/}
    kernel_name=${kernel_name%.*}

    if [ "x$default_defconfig" == "x" ] ; then
        default_defconfig=$kernel_defconfig
    elif [ -f $default_defconfig ]; then
        cp $default_defconfig ${tmp_dir}/
        kernel_defconfig=${tmp_dir}/${default_defconfig##*/}
    else
        echo `date` - ERROR, config file $default_defconfig can not be found.
        exit 2
    fi
    if [ "x$spec_param" == "xheadless" ] || [ "x$spec_param" == "x" ]; then
        img_spec="headless"
    elif [ "x$spec_param" == "xstandard" ] || [ "x$spec_param" == "xfull" ]; then
        img_spec=$spec_param
    else
        echo `date` - ERROR, please check your params in option -s or --spec.
        exit 2
    fi
    if [ "x$repo_file" == "x" ] ; then
        echo `date` - ERROR, \"-r REPO_INFO or --repo REPO_INFO\" missing.
        help 2
    elif [ "x${repo_file:0:4}" == "xhttp" ]; then
        if [ "x${repo_file:0-5}" == "x.repo" ]; then
            wget ${repo_file} -P ${tmp_dir}/
            repo_file_name=${repo_file##*/}
            repo_file=${tmp_dir}/${repo_file_name}
        else
            repo_file_name=tmp.repo
            repo_file_tmp=${tmp_dir}/${repo_file_name}
            index=1
            for baseurl in ${repo_file// / }
            do
                echo [repo${index}] >> ${repo_file_tmp}
                echo name=repo${index} to build raspi image >> ${repo_file_tmp}
                echo baseurl=${baseurl} >> ${repo_file_tmp}
                echo enabled=1 >> ${repo_file_tmp}
                echo gpgcheck=0 >> ${repo_file_tmp}
                echo >> ${repo_file_tmp}
                index=$(($index+1))
            done
            repo_file=${repo_file_tmp}
        fi
    else
        if [ ! -f $repo_file ]; then
            echo `date` - ERROR, repo file $repo_file can not be found.
            exit 2
        else
            cp $repo_file ${tmp_dir}/
            repo_file_name=${repo_file##*/}
            repo_file=${tmp_dir}/${repo_file_name}
        fi
    fi

    repo_suffix=${repo_file_name%.*}
    if [ "x$img_name" == "x" ]; then
        if [[ "${repo_suffix}" =~ ^${OS_NAME}.* ]]; then
            img_name=${repo_suffix}
        else
            img_name=${OS_NAME}
        fi
        img_name=${img_name}-raspi-aarch64-${buildid}.img
    else
        if [ "x${img_name:0-4}" != "x.img" ]; then
            img_name=${img_name}.img
        fi
    fi
    img_file=${img_dir}/${img_name}

    if [ ! -d ${log_dir} ]; then
        mkdir -p ${log_dir}
    fi
    LOG "prepare begin..."
    dnf clean all
    dnf makecache
    dnf install -y bison flex openssl-devel bc wget dnf-plugins-core tar parted dosfstools grep bash xz kpartx

    repo_info_names=`cat ${repo_file} | grep "^\["`
    repo_baseurls=`cat ${repo_file} | grep "^baseurl="`
    index=1
    for repo_name in ${repo_info_names}
    do
        repo_name_list[$index]=${repo_name:1:-1}
        index=$((index+1))
    done
    index=1
    for baseurl in ${repo_baseurls}
    do
        repo_info="${repo_info} --repofrompath ${repo_name_list[$index]}-tmp,${baseurl:8}"
        index=$((index+1))
    done
    set +e
    os_release_name=${OS_NAME}-release
    dnf ${repo_info} --disablerepo="*" --downloaddir=${tmp_dir}/ download ${os_release_name}
    if [ $? != 0 ]; then
        ERROR "Fail to download ${os_release_name}!"
        exit 2
    fi
    os_release_name=`ls -r ${tmp_dir}/${os_release_name}*.rpm 2>/dev/null| head -n 1`
    if [ -z "${os_release_name}" ]; then
        ERROR "${os_release_name} can not be found!"
        exit 2
    fi
    set -e

    wget https://raw.githubusercontent.com/RPi-Distro/raspberrypi-sys-mods/master/etc.armhf/udev/rules.d/99-com.rules -P ${tmp_dir}/
    wget https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/plain/regulatory.db.p7s -P ${tmp_dir}/
    wget https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/plain/regulatory.db -P ${tmp_dir}/
    if [ ! -d ${img_dir} ]; then
        mkdir -p ${img_dir}
    fi
    LOG "prepare end."
}

update_firmware_app(){
    LOG "update firmware and app begin..."
    cd "${workdir}"
    ######## firmware
    if [[ ! -d firmware ]]; then
        git clone --depth=1 https://github.com/raspberrypi/firmware
        if [[ $? -eq 0 ]]; then
            LOG "clone firmware done."
        else
            ERROR "clone firmware failed."
            exit 1
        fi
    else
        cd firmware
        git pull origin master
        cd ../
    fi
    ######## bluez-firmware
    if [[ ! -d bluez-firmware ]]; then
        git clone --depth=1 https://github.com/RPi-Distro/bluez-firmware
        if [[ $? -eq 0 ]]; then
            LOG "clone bluez-firmware done."
        else
            ERROR "clone bluez-firmware failed."
            exit 1
        fi
    else
        cd bluez-firmware
        git pull origin master
        cd ../
    fi
    ######## firmware-nonfree
    if [[ ! -d firmware-nonfree ]]; then
        git clone --depth=1 https://github.com/RPi-Distro/firmware-nonfree
        if [[ $? -eq 0 ]]; then
            LOG "clone firmware-nonfree done."
        else
            ERROR "clone firmware-nonfree failed."
            exit 1
        fi
    else
        cd firmware-nonfree
        git pull origin master
        cd ../
    fi
    ######## pi-bluetooth
    if [[ ! -d pi-bluetooth ]]; then
        git clone https://github.com/RPi-Distro/pi-bluetooth
        if [[ $? -eq 0 ]]; then
            LOG "clone pi-bluetooth done."
        else
            ERROR "clone pi-bluetooth failed."
            exit 1
        fi
    else
        cd pi-bluetooth
        git pull origin master
        cd ../
    fi
    LOG "update firmware and app end."
}

make_kernel(){
    LOG "make kernel(${default_defconfig}) begin..."
    kernel_dir_tmp=$1
    cd "${kernel_dir_tmp}"
    if [ "x${kernel_defconfig:0:1}" != "x/" ]; then
        if [ ! -f arch/arm64/configs/${kernel_defconfig} ]; then
            ERROR "config file ${kernel_defconfig} can not be found in kernel source".
            exit 2
        fi
        kernel_commitid=$(git rev-parse HEAD)
        output_dir=${output_dir}/${kernel_commitid}
        if [ -f ${output_dir}/.${kernel_defconfig}.DONE ] ; then
            LOG This kernel has already been built successfully before. Use the last built kernel image.
            return 0
        fi
        kernel_defconfig=arch/arm64/configs/${kernel_defconfig}
    fi
    find ${output_dir}/ -mindepth 1 -maxdepth 1 -print0 | xargs -0 rm -rf
    make distclean
    cp ${kernel_defconfig} .config
    make ARCH=arm64 olddefconfig
    kernel_defconfig=${kernel_defconfig##*/}
    make ARCH=arm64 -j${make_cores}
    if [[ $? -eq 0 ]]; then
        mkdir -p ${output_dir}
        make ARCH=arm64 INSTALL_MOD_PATH=${output_dir}/ modules_install
        if [[ $? -eq 0 ]]; then
            cp arch/arm64/boot/Image ${output_dir}/
            cp arch/arm64/boot/dts/broadcom/*.dtb ${output_dir}/
            mkdir ${output_dir}/overlays
            cp arch/arm64/boot/dts/overlays/*.dtb* ${output_dir}/overlays/
            LOG "kernel content in ${output_dir}."
        else
            ERROR "modules install failed!"
            exit 1
        fi
    else
        ERROR "make ARCH=arm64 -j${make_cores} failed!"
        exit 1
    fi
    touch ${output_dir}/.${kernel_defconfig}.DONE
    LOG "make kernel(${default_defconfig}) end."
}

update_kernel(){
    LOG "update kernel begin..."
    cd "${workdir}"
    kernel_dir=""
    for file in `ls`
    do
        if [[ ${file} = ${kernel_name} && -d ${file}/.git ]]; then
            kernel_dir=${workdir}/${file}
            break
        fi
    done

    if [[ ${kernel_dir} = "" ]]; then
        git clone ${kernel_url}
        if [[ $? -eq 0 ]]; then
            LOG "clone ${kernel_name} done."
        else
            ERROR "clone ${kernel_name} failed."
            exit 1
        fi
        kernel_dir=${workdir}/${kernel_name}
    else
        cd "${kernel_name}"
        remote_url_exist=`git remote -v | grep "origin"`
        remote_url=`git ls-remote --get-url origin`
        if [[ ${remote_url_exist} = "" || ${remote_url} != ${kernel_url} ]]; then
            cd ../
            rm -rf ${kernel_name}
            git clone ${kernel_url}
            if [[ $? -eq 0 ]]; then
                LOG "clone ${kernel_name} done."
            else
                ERROR "clone ${kernel_name} failed."
                exit 1
            fi
        fi
    fi
    cd "${kernel_dir}"
    make distclean
    cur_branch=`git branch | grep \*`
    cur_branch=${cur_branch##*\ }
    exist_branch=0
    if [[ ${cur_branch} = ${kernel_branch} ]]; then
        exist_branch=1
    else
        for branch in `git branch -a`
        do
            branch=${branch##*\ }
            if [[ ${branch} = ${kernel_branch} ]]; then
                exist_branch=1
                git checkout ${kernel_branch}
                break
            fi
        done
        if [[ ${exist_branch} -eq 0 ]]; then
            git fetch origin
            for branch in `git branch -a`
            do
                branch=${branch##*\ }
                if [[ ${branch} = "remotes/origin/${kernel_branch}" ]]; then
                    git checkout remotes/origin/${kernel_branch}
                    git checkout -b ${kernel_branch}
                    LOG "git checkout -b ${kernel_branch} done."
                    exist_branch=1
                    break
                fi
            done
        fi
    fi
    if [[ ${exist_branch} -eq 0 ]]; then
        ERROR "no ${kernel_branch} found."
        exit 1
    else
        set +e
        git pull origin ${kernel_branch} # git_rst=`xxx`
        if [ $? -ne 0 ]; then
            git reset --hard remotes/origin/${kernel_branch}
        fi
        set -e
        make_kernel ${kernel_dir}
    fi
    LOG "update kernel end."
}

make_rootfs(){
    LOG "make rootfs for ${repo_file} begin..."
    if [[ -d ${rootfs_dir} ]]; then
        UMOUNT_ALL
        rm -rf ${rootfs_dir}
    fi
    mkdir -p ${rootfs_dir}/var/lib/rpm
    rpm --root ${rootfs_dir} --initdb
    rpm -ivh --nodeps --root ${rootfs_dir}/ ${os_release_name}
    mkdir -p ${rootfs_dir}/etc/rpm
    chmod a+rX ${rootfs_dir}/etc/rpm
    echo "%_install_langs en_US" > ${rootfs_dir}/etc/rpm/macros.image-language-conf
    if [[ ! -d ${rootfs_dir}/etc/yum.repos.d ]]; then
        mkdir -p ${rootfs_dir}/etc/yum.repos.d
    fi
    cp ${repo_file} ${rootfs_dir}/etc/yum.repos.d/tmp.repo
    set +e
    if [ $img_spec == "headless" ]; then
        INSTALL_PACKAGES $CONFIG_RPM_LIST
    elif [ $img_spec == "standard" ]; then
        INSTALL_PACKAGES $CONFIG_STANDARD_LIST
    elif [ $img_spec == "full" ]; then
        INSTALL_PACKAGES $CONFIG_FULL_LIST
    fi
    cat ${rootfs_dir}/etc/systemd/timesyncd.conf | grep "^NTP*"
    if [ $? -ne 0 ]; then
        sed -i 's/#NTP=/NTP=0.cn.pool.ntp.org/g' ${rootfs_dir}/etc/systemd/timesyncd.conf
        sed -i 's/#FallbackNTP=/FallbackNTP=1.asia.pool.ntp.org 2.asia.pool.ntp.org/g' ${rootfs_dir}/etc/systemd/timesyncd.conf
    fi
    set -e
    cp ${euler_dir}/hosts ${rootfs_dir}/etc/hosts
    if [ ! -d $rootfs_dir/etc/sysconfig/network-scripts ]; then
        mkdir -p $rootfs_dir/etc/sysconfig/network-scripts
    fi
    cp ${euler_dir}/ifup-eth0 $rootfs_dir/etc/sysconfig/network-scripts/ifup-eth0
    mkdir -p ${rootfs_dir}/lib/firmware ${rootfs_dir}/usr/bin ${rootfs_dir}/lib/udev/rules.d ${rootfs_dir}/lib/systemd/system
    cp ${workdir}/bluez-firmware/broadcom/* ${rootfs_dir}/lib/firmware/
    cp -r ${workdir}/firmware-nonfree/brcm/ ${rootfs_dir}/lib/firmware/
    mv ${rootfs_dir}/lib/firmware/BCM43430A1.hcd ${rootfs_dir}/lib/firmware/brcm/
    mv ${rootfs_dir}/lib/firmware/BCM4345C0.hcd ${rootfs_dir}/lib/firmware/brcm/
    cp ${tmp_dir}/regulatory.db* ${rootfs_dir}/lib/firmware/
    cp ${tmp_dir}/*.rules ${rootfs_dir}/lib/udev/rules.d/
    cp ${workdir}/pi-bluetooth/usr/bin/* ${rootfs_dir}/usr/bin/
    cp ${workdir}/pi-bluetooth/lib/udev/rules.d/90-pi-bluetooth.rules ${rootfs_dir}/lib/udev/rules.d/
    cp ${workdir}/pi-bluetooth/debian/pi-bluetooth.bthelper\@.service ${rootfs_dir}/lib/systemd/system/bthelper\@.service
    cp ${workdir}/pi-bluetooth/debian/pi-bluetooth.hciuart.service ${rootfs_dir}/lib/systemd/system/hciuart.service
    cp -r ${output_dir}/lib/modules ${rootfs_dir}/lib/
    mkdir -p ${rootfs_dir}/usr/share/licenses/raspi
    cp ${euler_dir}/License/* ${rootfs_dir}/usr/share/licenses/raspi/
    cp ${euler_dir}/chroot.sh ${rootfs_dir}/chroot.sh
    chmod +x ${rootfs_dir}/chroot.sh
    mount --bind /dev ${rootfs_dir}/dev
    mount -t proc /proc ${rootfs_dir}/proc
    mount -t sysfs /sys ${rootfs_dir}/sys
    chroot ${rootfs_dir} /bin/bash -c "echo 'Y' | /chroot.sh"
    UMOUNT_ALL
    rm ${rootfs_dir}/etc/yum.repos.d/tmp.repo
    rm ${rootfs_dir}/chroot.sh
    LOG "make rootfs for ${repo_file} end."
}

make_img(){
    LOG "make ${img_file} begin..."
    device=""
    LOSETUP_D_IMG
    size=`du -sh --block-size=1MiB ${rootfs_dir} | cut -f 1 | xargs`
    size=$(($size+1150))
    losetup -D
    dd if=/dev/zero of=${img_file} bs=1MiB count=$size && sync
    parted ${img_file} mklabel msdos mkpart primary fat32 8192s 593919s
    parted ${img_file} -s set 1 boot
    parted ${img_file} mkpart primary linux-swap 593920s 1593343s
    parted ${img_file} mkpart primary ext4 1593344s 100%
    device=`losetup -f --show -P ${img_file}`
    LOG "after losetup: ${device}"
    trap 'LOSETUP_D_IMG' EXIT
    LOG "image ${img_file} created and mounted as ${device}"
    kpartx -va ${device}
    loopX=${device##*\/}
    partprobe ${device}
    bootp=/dev/mapper/${loopX}p1
    swapp=/dev/mapper/${loopX}p2
    rootp=/dev/mapper/${loopX}p3
    LOG "bootp: " ${bootp} "rootp: " ${rootp}
    mkfs.vfat -n boot ${bootp}
    mkswap ${swapp}
    mkfs.ext4 ${rootp}
    mkdir -p ${root_mnt} ${boot_mnt}
    mount -t vfat -o uid=root,gid=root,umask=0000 ${bootp} ${boot_mnt}
    mount -t ext4 ${rootp} ${root_mnt}
    fstab_array=("" "" "" "")
    for line in `blkid | grep /dev/mapper/${loopX}p`
    do
        uuid=${line#*UUID=\"}
        fstab_array[${line:18:1}]=${uuid%%\"*}
    done
    echo "UUID=${fstab_array[3]}  / ext4    defaults,noatime 0 0" > ${rootfs_dir}/etc/fstab
    echo "UUID=${fstab_array[1]}  /boot vfat    defaults,noatime 0 0" >> ${rootfs_dir}/etc/fstab
    echo "UUID=${fstab_array[2]}  swap swap    defaults,noatime 0 0" >> ${rootfs_dir}/etc/fstab

    cp -rf --preserve=mode,timestamps --no-preserve=ownership ${workdir}/firmware/boot/* ${boot_mnt}/
    pushd ${boot_mnt}/
    rm -f *.dtb cmdline.txt kernel.img kernel7.img kernel7l.img
    cp ${euler_dir}/config.txt ./
    echo "console=serial0,115200 console=tty1 root=/dev/mmcblk0p3 rootfstype=ext4 elevator=deadline rootwait" > cmdline.txt
    popd
    cp --preserve=mode,timestamps --no-preserve=ownership ${output_dir}/Image ${boot_mnt}/kernel8.img
    cp --preserve=mode,timestamps --no-preserve=ownership ${output_dir}/*.dtb ${boot_mnt}/
    cp --preserve=mode,timestamps --no-preserve=ownership ${output_dir}/overlays/* ${boot_mnt}/overlays/

    if [ -f ${tmp_dir}/rootfs.tar ]; then
        rm ${tmp_dir}/rootfs.tar
    fi
    pushd ${rootfs_dir}
    rm -rf boot
    tar cpf ${tmp_dir}/rootfs.tar .
    popd
    pushd ${root_mnt}
    tar xpf ${tmp_dir}/rootfs.tar -C .
    for tmpdir in `ls ${output_dir}/lib/modules`
    do
        if [ -d ./lib/modules/${tmpdir} ]; then
            if [ -L ./lib/modules/${tmpdir}/build ]; then
                rm -rf ./lib/modules/${tmpdir}/build
            fi
            if [ -L ./lib/modules/${tmpdir}/source ]; then
                rm -rf ./lib/modules/${tmpdir}/source
            fi
        fi
    done
    popd
    sync
    sleep 10
    LOSETUP_D_IMG
    rm ${tmp_dir}/rootfs.tar
    rm -rf ${rootfs_dir}
    losetup -D
    pushd ${img_dir}
    if [ -f ${img_file} ]; then
        sha256sum $(basename ${img_file}) > ${img_file}.sha256sum
        xz -T 20 -z -c ${img_file} > ${img_file}.xz
        sha256sum $(basename ${img_file}.xz) > ${img_file}.xz.sha256sum
        LOG "made sum files for ${img_file}"
    fi
    popd
    LOG "write ${img_file} done."
    LOG "make ${img_file} end."
}

if [ "$EUID" -ne 0 ]; then
    echo `date` - ERROR, Please run as root!
    exit
fi

kernel_url="https://gitee.com/openeuler/raspberrypi-kernel.git"
kernel_branch="master"
kernel_defconfig="openeuler-raspi_defconfig"
default_defconfig=""
make_cores=$(nproc)

parseargs "$@" || help $?

OS_NAME=openEuler

cur_dir=$(cd $(dirname $0);pwd)

workdir=${cur_dir}
if [ "x${workdir}" == "x/" ]; then
    workdir=/raspi_output_common
else
    workdir=${workdir}/raspi_output_common
fi

buildid=$(date +%Y%m%d%H%M%S)
builddate=${buildid:0:8}

tmp_dir=${workdir}/tmp
log_dir=${workdir}/log
img_dir=${workdir}/img
output_dir=${workdir}/output
rootfs_dir=${workdir}/rootfs
root_mnt=${workdir}/root
boot_mnt=${workdir}/boot
euler_dir=${cur_dir}/config-common

CONFIG_RPM_LIST=${euler_dir}/rpmlist
CONFIG_STANDARD_LIST=${euler_dir}/standardlist
CONFIG_FULL_LIST=${euler_dir}/fulllist
img_spec=""

trap 'UMOUNT_ALL' EXIT
UMOUNT_ALL
prepare
IFS=$'\n'
update_firmware_app
update_kernel

make_rootfs
make_img
