#!/bin/bash
set -e

if [[ $# -ne 0 && $# -ne 5 && $# -ne 7 ]]; then
    echo "params length: $# is not 0/5/7."
    echo Example1: bash $0
    echo Example2: bash $0 KERNEL_URL KERNEL_BRANCH KERNEL_DEFCONFIG DEFAULT_DEFCONFIG REPO_FILE --cores MAKE_CORES
    echo Example3: bash $0 KERNEL_URL KERNEL_BRANCH KERNEL_DEFCONFIG DEFAULT_DEFCONFIG REPO_FILE
    exit 1
fi
cur_dir=$(cd $(dirname $0);pwd)
run_dir=${cur_dir}
kernel_url="https://gitee.com/openeuler/raspberrypi-kernel.git"
kernel_branch="master"
kernel_defconfig="openeuler-raspi_defconfig"
default_defconfig="openeuler-raspi_defconfig"
repo_file=openEuler-20.03-LTS.repo

buildid=$(date +%Y%m%d%H%M%S)
builddate=${buildid:0:8}
output_dir=${run_dir}/output
rootfs_dir=${run_dir}/rootfs_${builddate}
root_mnt=${run_dir}/root
boot_mnt=${run_dir}/boot
make_cores=18
if [[ $# -eq 5 || $# -eq 7 ]]; then
    if [[ $1 != "" ]]; then
        kernel_url=$1
    fi
    if [[ $2 != "" ]]; then
        kernel_branch=$2
    fi
    if [[ $3 != "" ]]; then
        kernel_defconfig=$3
    fi
    if [[ $4 != "" ]]; then
        default_defconfig=$4
    fi
    if [[ $5 != "" ]]; then
        repo_file=$5
    fi
fi
if [[ $# -eq 7 && $6 == "--cores" && $7 -ne 0 ]]; then
    make_cores=$7
fi
kernel_name=${kernel_url##*/}
kernel_name=${kernel_name%.*}
repo_file_name=${repo_file##*/}
img_suffix=${repo_file_name%%-*}
img_suffix=`echo $img_suffix | grep -Eo "^[a-zA-Z ]*"`
os_release_name=${img_suffix}-release
img_file=${run_dir}/img/${builddate}/${repo_file_name%.*}-aarch64-raspi-${buildid}.img

ERROR(){
    echo `date` - ERROR, $* | tee -a ${cur_dir}/log/log_${builddate}.log
}

LOG(){
    echo `date` - INFO, $* | tee -a ${cur_dir}/log/log_${builddate}.log
}

prepare(){
    if [ ! -d ${cur_dir}/log ]; then
        mkdir ${cur_dir}/log
    fi
    LOG "prepare begin..."
    rmp_names=("bison" "flex" "parted" "wget" "multipath-tools")
    rmp_install_names=("bison" "flex" "parted" "wget" "kpartx")
    rmp_len=${#rmp_names[@]}
    for (( i=0; i<${rmp_len}; i++ ))
    do
        rpm -qa | grep ${rmp_names[i]} &> /dev/null
        [ $? -eq 0 ] || yum install -y ${rmp_install_names[i]} &> /dev/null
        [ $? -ne 0 ] && echo "yum install ${rmp_install_names[i]} failed." && ERROR "yum install ${rmp_install_names[i]} failed." && yum_right=3
    done
    [ $yum_right ] && exit 3
    if [ ! -d ${run_dir}/img ]; then
        mkdir ${run_dir}/img
    fi
    if [ ! -d ${cur_dir}/tmp ]; then
        mkdir ${cur_dir}/tmp
    fi
    
    if [ "${repo_file:0:4}" = "http" ]; then
        # rpm_url=`wget -q -O - ${repo_file} | grep "^baseurl=" | cut -d '=' -f 2 | xargs`
        rm -f ${cur_dir}/tmp/*.repo
        wget ${repo_file} -P ${cur_dir}/tmp/
    else
        # rpm_url=`cat ${repo_file} | grep "^baseurl=" | grep "everything" | cut -d '=' -f 2 | xargs`
        cp ${cur_dir}/config/${repo_file} ${cur_dir}/tmp/${repo_file_name}
    fi
    if [ $? -ne 0 ]; then
        ERROR ${repo_file} not found.
        exit 1
    else
        yumdownloader --downloaddir=${cur_dir}/tmp/ $os_release_name -c ${cur_dir}/tmp/${repo_file_name}
        os_release_name=`ls -r ${cur_dir}/tmp/${os_release_name}*.rpm | head -n 1`
        if [ -z "${os_release_name}" ]; then
            ERROR "Fail to download ${os_release_name}!"
            exit 1
        fi
    fi
    rm -f ${cur_dir}/tmp/*.rules
    wget https://raw.githubusercontent.com/RPi-Distro/raspberrypi-sys-mods/master/etc.armhf/udev/rules.d/99-com.rules -P ${cur_dir}/tmp/
    rm -f ${cur_dir}/tmp/regulatory.db*
    wget https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/tree/regulatory.db.p7s -P ${cur_dir}/tmp/
    wget https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/tree/regulatory.db -P ${cur_dir}/tmp/
    if [ ! -d ${run_dir}/img/${builddate} ]; then
        mkdir -p ${run_dir}/img/${builddate}
    fi
    LOG "prepare end."
}

update_firmware_app(){
    LOG "update firmware and app begin..."
    cd "${run_dir}"
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
    LOG "make kernel begin..."
    kernel_dir_tmp=$1
    cd "${kernel_dir_tmp}"
    if [[ ${kernel_defconfig} != "" ]]; then
        if [[ -f ${cur_dir}/config/${kernel_defconfig} ]]; then
            cur_config=${cur_dir}/config/${kernel_defconfig}
        elif [[ -f arch/arm64/configs/${kernel_defconfig} ]]; then
            cur_config=arch/arm64/configs/${kernel_defconfig}
        else
            ERROR "kernel config: ${kernel_defconfig} not found."
            exit 1
        fi
    elif [[ -f arch/arm64/configs/${default_defconfig} ]]; then
        cur_config=arch/arm64/configs/${default_defconfig}
        kernel_defconfig=${default_defconfig}
    else
        ERROR "kernel config: ${default_defconfig} not found."
        exit 1
    fi
    # make ARCH=arm64 ${kernel_defconfig}
    # if [[ $? -eq 0 ]]; then
    #     ####
    # else
    #     ERROR "make ARCH=arm64 ${kernel_defconfig} failed!"
    #     exit 1
    # fi
    kernel_commitid=$(git rev-parse HEAD)
    output_dir=${output_dir}/${kernel_commitid}
    if [ -f ${output_dir}/.${kernel_defconfig}.DONE ] ; then
        echo This kernel has already been built successfully before. Use the last built kernel image.
        return 0
    fi
    find ${output_dir}/ -mindepth 1 -maxdepth 1 -print0 | xargs -0 rm -rf
    make distclean
    cp ${cur_config} .config
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
    LOG "make kernel end."
}

update_kernel(){
    LOG "update kernel begin..."
    cd "${run_dir}"
    kernel_dir=""
    for file in `ls`
    do
        if [[ ${file} = ${kernel_name} && -d ${file}/.git ]]; then
            kernel_dir=${run_dir}/${file}
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
        kernel_dir=${run_dir}/${kernel_name}
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
                    # git config --global user.name "yafen"
                    # git config --global user.email "yafen@iscas.ac.cn"
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
        git pull origin ${kernel_branch} # git_rst=`xxx`
        make_kernel ${kernel_dir}
    fi
    # if [[ ${git_rst} = Already* ]]; then
    #     echo "updated."
    #     if [ ! -d ${run_dir}/output ]; then
    #         make_kernel ${kernel_dir}
    #     else
    #         output_dir=${run_dir}/output
    #     fi
    # elif [[ ${git_rst} = fatal* ]]; then
    #     echo "get newest kernel failed!!!"
    #     ERROR "get newest kernel failed!!!"
    #     exit 1
    # else
    #     cd "${kernel_dir}"
    #     make_kernel ${kernel_dir}
    # fi
    LOG "update kernel end."
}

make_rootfs(){
    LOG "make rootfs for ${repo_file} begin..."
    cd "${run_dir}"
    if [[ -d ${rootfs_dir} ]]; then
        if [[ -d ${rootfs_dir}/dev && `ls ${rootfs_dir}/dev | wc -l` -gt 1 ]]; then
            umount -l ${rootfs_dir}/dev
        fi
        if [[ -d ${rootfs_dir}/proc && `ls ${rootfs_dir}/proc | wc -l` -gt 0 ]]; then
            umount -l ${rootfs_dir}/proc
        fi
        if [[ -d ${rootfs_dir}/sys && `ls ${rootfs_dir}/sys | wc -l` -gt 0 ]]; then
            umount -l ${rootfs_dir}/sys
        fi
        rm -rf ${rootfs_dir}
    fi
    mkdir ${rootfs_dir}
    mkdir -p ${rootfs_dir}/var/lib/rpm
    rpm --root ${rootfs_dir} --initdb
    rpm -ivh --nodeps --root ${rootfs_dir}/ ${os_release_name}
    if [[ ! -d ${rootfs_dir}/etc/yum.repos.d ]]; then
        mkdir -p ${rootfs_dir}/etc/yum.repos.d
    fi
    cp ${cur_dir}/tmp/*.repo $rootfs_dir/etc/yum.repos.d/
    dnf --installroot=${rootfs_dir}/ install dnf --nogpgcheck -y #--repofrompath=${repo_file_name},${rootfs_dir}/etc/yum.repos.d/${repo_file_name}
    dnf --installroot=${rootfs_dir}/ makecache
    dnf --installroot=${rootfs_dir}/ install -y alsa-utils wpa_supplicant vim net-tools iproute iputils NetworkManager openssh-server passwd hostname ntp bluez pulseaudio-module-bluetooth
    set +e
    cat ${rootfs_dir}/etc/ntp.conf | grep "^server*"
    if [ $? -ne 0 ]; then
        echo -e "\nserver 0.cn.pool.ntp.org\nserver 1.asia.pool.ntp.org\nserver 2.asia.pool.ntp.org\nserver 127.0.0.1">>${rootfs_dir}/etc/ntp.conf
    fi
    cat ${rootfs_dir}/etc/ntp.conf | grep "^fudge*"
    if [ $? -ne 0 ]; then
        echo -e "\nfudge 127.0.0.1 stratum 10">>${rootfs_dir}/etc/ntp.conf
    fi
    set -e
    cp ${cur_dir}/config/hosts ${rootfs_dir}/etc/hosts
    # cp ${cur_dir}/config/resolv.conf $rootfs_dir/etc/resolv.conf
    if [ ! -d $rootfs_dir/etc/sysconfig/network-scripts ]; then
        mkdir -p $rootfs_dir/etc/sysconfig/network-scripts
    fi
    cp ${cur_dir}/config/ifup-eth0 $rootfs_dir/etc/sysconfig/network-scripts/ifup-eth0
    mkdir -p ${rootfs_dir}/lib/firmware ${rootfs_dir}/usr/bin ${rootfs_dir}/lib/udev/rules.d ${rootfs_dir}/lib/systemd/system
    cp bluez-firmware/broadcom/* ${rootfs_dir}/lib/firmware/
    cp -r firmware-nonfree/brcm/ ${rootfs_dir}/lib/firmware/
    mv ${rootfs_dir}/lib/firmware/BCM43430A1.hcd ${rootfs_dir}/lib/firmware/brcm/
    mv ${rootfs_dir}/lib/firmware/BCM4345C0.hcd ${rootfs_dir}/lib/firmware/brcm/
    cp ${cur_dir}/tmp/regulatory.db* ${rootfs_dir}/lib/firmware/
    cp ${cur_dir}/tmp/*.rules ${rootfs_dir}/lib/udev/rules.d/
    cp pi-bluetooth/usr/bin/* ${rootfs_dir}/usr/bin/
    cp pi-bluetooth/lib/udev/rules.d/90-pi-bluetooth.rules ${rootfs_dir}/lib/udev/rules.d/
    cp pi-bluetooth/debian/pi-bluetooth.bthelper\@.service ${rootfs_dir}/lib/systemd/system/bthelper\@.service
    cp pi-bluetooth/debian/pi-bluetooth.hciuart.service ${rootfs_dir}/lib/systemd/system/hciuart.service
    cp -r ${output_dir}/lib/modules ${rootfs_dir}/lib/
    cp ${cur_dir}/scripts/chroot.sh ${rootfs_dir}/chroot.sh
    chmod +x ${rootfs_dir}/chroot.sh
    mount --bind /dev ${rootfs_dir}/dev
    mount -t proc /proc ${rootfs_dir}/proc
    mount -t sysfs /sys ${rootfs_dir}/sys
    chroot ${rootfs_dir} /bin/bash -c "echo 'Y' | /chroot.sh"
    umount -l ${rootfs_dir}/dev
    umount -l ${rootfs_dir}/proc
    umount -l ${rootfs_dir}/sys
    rm ${rootfs_dir}/chroot.sh
    LOG "make rootfs for ${repo_file} end."
}

make_img(){
    LOG "make ${img_file} begin..."
    cd "${run_dir}"
    size=`du -sh --block-size=1MiB ${rootfs_dir} | cut -f 1 | xargs`
    size=$(($size+1100))
    losetup -D
    dd if=/dev/zero of=${img_file} bs=1MiB count=$size && sync
    parted ${img_file} mklabel msdos mkpart primary fat32 8192s 593919s
    parted ${img_file} -s set 1 boot
    parted ${img_file} mkpart primary linux-swap 593920s 1593343s 
    parted ${img_file} mkpart primary ext4 1593344s 100%
    device=`losetup -f --show -P ${img_file}`
    LOG "after losetup: ${device}"
    LOG "image ${img_file} created and mounted as ${device}"
    # loopX=`kpartx -va ${device} | sed -E 's/.*(loop[0-9])p.*/\1/g' | head -1`
    # LOG "after kpartx: ${loopX}"
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
    set +e
    if [ -d ${root_mnt} ]; then
        df -lh | grep ${root_mnt}
        if [ $? -eq 0 ]; then
            umount ${root_mnt}
        fi
        rm -rf ${root_mnt}
    fi
    if [ -d ${boot_mnt} ]; then
        df -lh | grep ${boot_mnt}
        if [ $? -eq 0 ]; then
            umount ${boot_mnt}
        fi
        rm -rf ${boot_mnt}
    fi
    set -e
    mkdir ${root_mnt} ${boot_mnt}
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

    cp -rf --preserve=mode,timestamps --no-preserve=ownership ${run_dir}/firmware/boot/* ${boot_mnt}/
    pushd ${boot_mnt}/
    rm -f *.dtb cmdline.txt kernel.img kernel7.img kernel7l.img
    cp ${cur_dir}/config/config.txt ./
    echo "console=serial0,115200 console=tty1 root=/dev/mmcblk0p3 rootfstype=ext4 elevator=deadline rootwait" > cmdline.txt
    popd
    cp --preserve=mode,timestamps --no-preserve=ownership ${output_dir}/Image ${boot_mnt}/kernel8.img
    cp --preserve=mode,timestamps --no-preserve=ownership ${output_dir}/*.dtb ${boot_mnt}/
    cp --preserve=mode,timestamps --no-preserve=ownership ${output_dir}/overlays/* ${boot_mnt}/overlays/

    if [ -f ${run_dir}/rootfs.tar ]; then
        rm ${run_dir}/rootfs.tar
    fi
    cd ${rootfs_dir}
    tar cpf ${run_dir}/rootfs.tar .
    cd ${root_mnt}
    tar xpf ${run_dir}/rootfs.tar -C .
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
    cd "${run_dir}"
    sync
    sleep 10
    umount ${root_mnt}
    umount ${boot_mnt}

    kpartx -d ${device}
    losetup -d ${device}

    rm ${run_dir}/rootfs.tar
    if [ -f ${img_file} ]; then
        md5sum ${img_file} > ${img_file}.md5sum
        xz -T 20 -z -c ${img_file} > ${img_file}.xz
        md5sum ${img_file}.xz > ${img_file}.xz.md5sum
        LOG "made sum files for ${img_file}"
    fi
    # rm -rf ${output_dir}
    rm -rf ${rootfs_dir}
    losetup -D
    LOG "write ${img_file} done."
    LOG "make ${img_file} end."
}

IFS=$'\n'
prepare
update_firmware_app
update_kernel

make_rootfs
make_img

