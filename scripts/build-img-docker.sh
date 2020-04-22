#!/bin/bash

set -e

cur_dir=$(cd $(dirname $0);pwd)
cd "${cur_dir}"

if [[ $# -ne 0 && $# -ne 6 && $# -ne 8 ]]; then
    echo Error: params length: $# is not 0/6/8.
    echo Example1: bash $0
    echo Example2: bash $0 DOCKER_FILE KERNEL_URL KERNEL_BRANCH KERNEL_DEFCONFIG DEFAULT_DEFCONFIG REPO_FILE --cores MAKE_CORES
    echo Example3: bash $0 DOCKER_FILE KERNEL_URL KERNEL_BRANCH KERNEL_DEFCONFIG DEFAULT_DEFCONFIG REPO_FILE
    exit 1
fi

docker_file="https://repo.openeuler.org/openEuler-20.03-LTS/docker_img/aarch64/openEuler-docker.aarch64.tar.xz"
kernel_url="https://gitee.com/openeuler/raspberrypi-kernel.git"
kernel_branch="openEuler-1.0-LTS-raspi"
kernel_defconfig="openeuler-raspi_defconfig"
default_defconfig="openeuler-raspi_defconfig"
repo_file=openEuler-20.03-LTS.repo

make_cores=18
if [[ $# -eq 6 || $# -eq 8 ]]; then
    if [[ $1 != "" ]]; then
        docker_file=$1
    fi
    if [[ $2 != "" ]]; then
        kernel_url=$2
    fi
    if [[ $3 != "" ]]; then
        kernel_branch=$3
    fi
    if [[ $4 != "" ]]; then
        kernel_defconfig=$4
    fi
    if [[ $5 != "" ]]; then
        default_defconfig=$5
    fi
    if [[ $6 != "" ]]; then
        repo_file=$6
    fi
fi
if [[ $# -eq 8 && $7 == "--cores" && $8 -ne 0 ]]; then
    make_cores=$8
fi

buildid=$(date +%Y%m%d%H%M%S)
builddate=${buildid:0:8}

if [ ! -d ${cur_dir}/log ]; then
    mkdir ${cur_dir}/log
fi
if [ ! -d ${cur_dir}/tmp ]; then
    mkdir ${cur_dir}/tmp
fi

ERROR(){
    echo `date` - ERROR, $* | tee -a ${cur_dir}/log/log_${builddate}.log
}

LOG(){
    echo `date` - INFO, $* | tee -a ${cur_dir}/log/log_${builddate}.log
}

docker_file_name=${docker_file##*/}
if [ "${docker_file:0:4}" = "http" ]; then
    if [ ! -f ${cur_dir}/tmp/${docker_file_name} ]; then
        wget ${docker_file} -P ${cur_dir}/tmp/
    fi
else
    cp ${cur_dir}/config/${docker_file} ${cur_dir}/tmp/
fi
docker_img_name=`docker load --input ${cur_dir}/tmp/${docker_file_name}`
docker_img_name=${docker_img_name##*: }

(echo "FROM $docker_img_name" && grep -v FROM config/Dockerfile_makeraspi) | docker build -t ${docker_img_name}-${buildid} --no-cache -f- .
echo docker run --rm --privileged=true -v ${cur_dir}:/work ${docker_img_name}-${buildid} $kernel_url $kernel_branch $kernel_defconfig $default_defconfig $repo_file --cores $make_cores
docker run --rm --privileged=true -v ${cur_dir}:/work ${docker_img_name}-${buildid} $kernel_url $kernel_branch $kernel_defconfig $default_defconfig $repo_file --cores $make_cores

chmod -R a+r ${cur_dir}/img
docker image rm ${docker_img_name}-${buildid}
echo
echo Done.

