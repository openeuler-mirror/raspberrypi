#!/bin/bash

set -e

__usage="
Usage: build-image-docker [OPTIONS]
Build raspberrypi image.

Options:
  -d, --docker DOCKER_FILE         The URL/path of the Docker image, which defaults to https://repo.openeuler.org/openEuler-20.03-LTS-SP1/docker_img/aarch64/openEuler-docker.aarch64.tar.xz
  -n, --name IMAGE_NAME            The raspberrypi image name to be built.
  -k, --kernel KERNEL_URL          The URL of kernel source's repository, which defaults to https://gitee.com/openeuler/raspberrypi-kernel.git.
  -b, --branch KERNEL_BRANCH       The branch name of kernel source's repository, which defaults to openEuler-20.03-LTS.
  -c, --config KERNEL_DEFCONFIG    The name/path of defconfig file when compiling kernel, which defaults to openeuler-raspi_defconfig.
  -r, --repo REPO_INFO             Required! The URL/path of target repo file or list of repo's baseurls which should be a space separated list.
  -s, --spec SPEC                  The image's specification: headless, xfce, ukui, dde or the file path of rpmlist. The default is headless.
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
        elif [ "x$1" == "x-d" -o "x$1" == "x--docker" ]; then
            docker_file=`echo $2`
            shift
            shift
        elif [ "x$1" == "x-n" -o "x$1" == "x--name" ]; then
            img_name=`echo $2`
            params="${params} -n ${img_name}"
            shift
            shift
        elif [ "x$1" == "x-k" -o "x$1" == "x--kernel" ]; then
            kernel_url=`echo $2`
            params="${params} -k ${kernel_url}"
            shift
            shift
        elif [ "x$1" == "x-b" -o "x$1" == "x--branch" ]; then
            kernel_branch=`echo $2`
            params="${params} -b ${kernel_branch}"
            shift
            shift
        elif [ "x$1" == "x-c" -o "x$1" == "x--config" ]; then
            default_defconfig=`echo $2`
            if [ "x$default_defconfig" != "x" ]; then
                if [ ! -f $default_defconfig ]; then
                    echo `date` - ERROR, config file $default_defconfig can not be found.
                    exit 2
                else
                    cp $default_defconfig ${params_dir}/
                    defconfig_name=${default_defconfig##*/}
                    default_defconfig=${params_dir_indocker}/${defconfig_name}
                fi
            fi
            params="${params} -c ${default_defconfig}"
            shift
            shift
        elif [ "x$1" == "x-r" -o "x$1" == "x--repo" ]; then
            repo_file=`echo $2`
            if [ "x$repo_file" != "x" -a "x${repo_file:0:4}" != "xhttp" ]; then
                if [ ! -f $repo_file ]; then
                    echo `date` - ERROR, repo file $repo_file can not be found.
                    exit 2
                else
                    cp $repo_file ${params_dir}/
                    repo_file_name=${repo_file##*/}
                    repo_file=${params_dir_indocker}/${repo_file_name}
                fi
            fi
            params="${params} -r ${repo_file}"
            shift
            shift
        elif [ "x$1" == "x-s" -o "x$1" == "x--spec" ]; then
            spec_param=`echo $2`
            if [ "x$spec_param" == "xheadless" ] || [ "x$spec_param" == "x" ] \
            || [ "x$spec_param" == "xxfce" ] || [ "x$spec_param" == "xukui" ] \
            || [ "x$spec_param" == "xdde" ]; then
                :
            elif [ -f $spec_param ]; then
                cp $spec_param ${params_dir}/
                spec_file_name=${spec_param##*/}
                $spec_param=${params_dir_indocker}/${spec_file_name}
            else
                echo `date` - ERROR, please check your params in option -s or --spec.
                exit 2
            fi
            params="${params} -s ${spec_param}"
            shift
            shift
        elif [ "x$1" == "x--cores" ]; then
            make_cores=`echo $2`
            params="${params} --cores ${make_cores}"
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

cur_dir=$(cd $(dirname $0);pwd)

docker_file="https://repo.openeuler.org/openEuler-20.03-LTS-SP1/docker_img/aarch64/openEuler-docker.aarch64.tar.xz"

workdir=${cur_dir}/raspi_output_common

buildid=$(date +%Y%m%d%H%M%S)
builddate=${buildid:0:8}

log_dir=${workdir}/log
params_dir=${workdir}/params
euler_dir=${cur_dir}/config-common
params_dir_indocker=/work/raspi_output_common/params

if [ -d ${params_dir} ]; then
    rm -rf ${params_dir}
fi
mkdir -p ${params_dir}

parseargs "$@" || help $?

if [ "x${docker_file:0:4}" == "xhttp" ]; then
    wget ${docker_file} -P ${params_dir}/
elif [ -f $docker_file ]; then
    cp ${docker_file} ${params_dir}/
else
    echo `date` - ERROR, docker file $docker_file can not be found.
    exit 2
fi

if [ "x$repo_file" == "x" ] ; then
    echo `date` - ERROR, \"-r REPO_INFO or --repo REPO_INFO\" missing.
    help 2
fi

if [ ! -d ${log_dir} ]; then
    mkdir ${log_dir}
fi
docker_file_name=${docker_file##*/}
docker_img_name=`docker load --input ${params_dir}/${docker_file_name}`
docker_img_name=${docker_img_name##*: }

LOG build raspi image with docker: ${docker_file}.

(echo "FROM $docker_img_name" && grep -v FROM ${euler_dir}/Dockerfile_makeraspi) | docker build -t ${docker_img_name}-${buildid} --no-cache -f- ${euler_dir}
echo docker run --rm --privileged=true \
    -v ${cur_dir}/build-image-common.sh:/work/build-image-common.sh \
    -v ${euler_dir}:/work/config-common \
    -v ${cur_dir}/config:/work/config \
    -v ${workdir}:/work/raspi_output_common \
    ${docker_img_name}-${buildid} ${params}
docker run --rm --privileged=true \
    -v ${cur_dir}/build-image-common.sh:/work/build-image-common.sh \
    -v ${euler_dir}:/work/config-common \
    -v ${cur_dir}/config:/work/config \
    -v ${workdir}:/work/raspi_output_common \
    ${docker_img_name}-${buildid} ${params}
chmod -R a+r ${workdir}/img
docker image rm ${docker_img_name}-${buildid}
LOG
LOG Done.

