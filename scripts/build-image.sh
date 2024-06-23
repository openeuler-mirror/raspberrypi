#!/bin/bash

set -e

__usage="
Usage: build-image [OPTIONS]
Build raspberrypi image.

Options:
  -d, --dir  DIR             The directory for storing the image and other temporary files, which defaults to be the directory in which the script resides. If the DIR does not exist, it will be created automatically.
  -r, --repo REPO_INFO       Required! The URL/path of target repo file or list of repo's baseurls which should be a space separated list.
  -n, --name IMAGE_NAME      The raspberrypi image name to be built.
  -s, --spec SPEC            The image's specification: headless, xfce, ukui, dde or the file path of rpmlist. The default is headless.
  -h, --help                 Show command help.
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
        elif [ "x$1" == "x-r" -o "x$1" == "x--repo" ]; then
            repo_file=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-n" -o "x$1" == "x--name" ]; then
            img_name=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-d" -o "x$1" == "x--dir" ]; then
            workdir=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-s" -o "x$1" == "x--spec" ]; then
            spec_param=`echo $2`
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
    if [ "x$spec_param" == "xheadless" ] || [ "x$spec_param" == "x" ]; then
        :
    elif [ "x$spec_param" == "xxfce" ] || [ "x$spec_param" == "xukui" ] || [ "x$spec_param" == "xdde" ]; then
        CONFIG_RPM_LIST=${euler_dir}/rpmlist-${spec_param}
    elif [ -f ${spec_param} ]; then
        cp ${spec_param} ${tmp_dir}/
        spec_file_name=${spec_param##*/}
        CONFIG_RPM_LIST=${tmp_dir}/${spec_file_name}
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
        img_name=${img_name}-raspi-aarch64.img
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
    dnf install -y dnf-plugins-core rsync parted dosfstools grep bash xz kpartx

    if [ -d ${rootfs_dir} ]; then
        rm -rf ${rootfs_dir}
    fi
    if [ ! -d ${img_dir} ]; then
        mkdir -p ${img_dir}
    fi

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
    LOG "prepare end."
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
    dnf --installroot=${rootfs_dir}/ makecache
    set +e
    INSTALL_PACKAGES $CONFIG_RPM_LIST
    cat ${rootfs_dir}/etc/systemd/timesyncd.conf | grep "^NTP=*"
    if [ $? -ne 0 ]; then
        sed -i -e '/^#NTP=/cNTP=0.cn.pool.ntp.org' ${rootfs_dir}/etc/systemd/timesyncd.conf
        sed -i -e 's/#FallbackNTP=/FallbackNTP=1.asia.pool.ntp.org 2.asia.pool.ntp.org /g' ${rootfs_dir}/etc/systemd/timesyncd.conf
    fi
    set -e
    cp ${euler_dir}/hosts ${rootfs_dir}/etc/hosts
    if [ ! -d $rootfs_dir/etc/sysconfig/network-scripts ]; then
        mkdir -p $rootfs_dir/etc/sysconfig/network-scripts
    fi
    cp ${euler_dir}/ifcfg-eth0 $rootfs_dir/etc/sysconfig/network-scripts/ifcfg-eth0
    mkdir -p ${rootfs_dir}/lib/udev/rules.d
    if [ ! -d ${rootfs_dir}/usr/share/licenses/raspi ]; then
        mkdir -p ${rootfs_dir}/usr/share/licenses/raspi
    fi
    cp ${euler_dir}/*.rules ${rootfs_dir}/lib/udev/rules.d/
    cp ${euler_dir}/LICENCE.* ${rootfs_dir}/usr/share/licenses/raspi/
    cp ${euler_dir}/chroot.sh ${rootfs_dir}/chroot.sh
    if [ ! -d ${rootfs_dir}/etc/rc.d/init.d ]; then
        mkdir -p ${rootfs_dir}/etc/rc.d/init.d
    fi
    cp ${euler_dir}/extend-root.sh ${rootfs_dir}/etc/rc.d/init.d/extend-root.sh
    echo net.ipv4.conf.wlan0.rp_filter=0 >> ${rootfs_dir}/etc/sysctl.conf
    chmod +x ${rootfs_dir}/chroot.sh
    mount --bind /dev ${rootfs_dir}/dev
    mount -t proc /proc ${rootfs_dir}/proc
    mount -t sysfs /sys ${rootfs_dir}/sys
    chroot ${rootfs_dir} /bin/bash -c "echo 'Y' | /chroot.sh ${spec_param}"
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
    size=$(($size+1500))
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
    mkswap ${swapp} --pagesize 4096
    mkfs.ext4 ${rootp}
    mkdir -p ${root_mnt} ${boot_mnt}
    mount -t vfat -o uid=root,gid=root,umask=0000 ${bootp} ${boot_mnt}
    mount -t ext4 ${rootp} ${root_mnt}
    prefix_len=${#loopX}
    let prefix_len=prefix_len+13
    fstab_array=("" "" "" "")
    for line in `blkid | grep /dev/mapper/${loopX}p`
    do
        partuuid=${line#*PARTUUID=\"}
        fstab_array[${line:$prefix_len:1}]=${partuuid%%\"*}
    done
    echo "PARTUUID=${fstab_array[3]}  / ext4    defaults,noatime 0 0" > ${rootfs_dir}/etc/fstab
    echo "PARTUUID=${fstab_array[1]}  /boot vfat    defaults,noatime 0 0" >> ${rootfs_dir}/etc/fstab
    echo "PARTUUID=${fstab_array[2]}  swap swap    defaults,noatime 0 0" >> ${rootfs_dir}/etc/fstab

    if [ -d ${rootfs_dir}/boot/grub2 ]; then
        rm -rf ${rootfs_dir}/boot/grub2
    fi
    cp -a ${rootfs_dir}/boot/* ${boot_mnt}/
    cp ${euler_dir}/config.txt ${boot_mnt}/
    echo "console=serial0,115200 console=tty1 root=PARTUUID=${fstab_array[3]} rootfstype=ext4 elevator=deadline rootwait net.ifnames=0" > ${boot_mnt}/cmdline.txt

    rm -rf ${rootfs_dir}/boot
    rsync -avHAXq ${rootfs_dir}/* ${root_mnt}
    sync
    sleep 10
    LOSETUP_D_IMG
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

cur_dir=$(cd $(dirname $0);pwd)
workdir=${cur_dir}

parseargs "$@" || help $?

if [ "x$workdir" == "x" ]; then
    echo `date` - ERROR, \"-d DIR or --dir DIR\" missing.
    help 2
elif [ ! -d ${workdir} ]; then
    echo `date` - INFO, output dir ${workdir} does not exists.
    mkdir -p ${workdir}
    echo `date` - INFO, output dir: ${workdir} created.
fi

OS_NAME=openEuler

workdir=$(cd $workdir; pwd)
if [ "x${workdir}" == "x/" ]; then
    workdir=/raspi_output
else
    workdir=${workdir}/raspi_output
fi

tmp_dir=${workdir}/tmp
log_dir=${workdir}/log
img_dir=${workdir}/img
rootfs_dir=${workdir}/rootfs
root_mnt=${workdir}/root
boot_mnt=${workdir}/boot
euler_dir=${cur_dir}/config

CONFIG_RPM_LIST=${euler_dir}/rpmlist
builddate=$(date +%Y%m%d)

trap 'UMOUNT_ALL' EXIT
UMOUNT_ALL
prepare
IFS=$'\n'
make_rootfs
make_img
