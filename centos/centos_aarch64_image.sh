#!/usr/bin/env bash
IMAGE_CACHE=$HOME/.terraform/image_cache

if [ ! -d $IMAGE_CACHE ]; then
  mkdir -p $IMAGE_CACHE
fi

PROJECT_DIR=`pwd`

echo "Image Cache Location: "
echo $IMAGE_CACHE
echo
echo "Project Directory: "
echo $PROJECT_DIR
echo

cd $IMAGE_CACHE

if [ -z "$1" ]
then
  echo "!! ------------------------------------------------------------- !!
!! ERROR: No CENTOS_RELEASE argument supplied to script. Please  !!
!! supply '7 or 8'  as the option to the script.                 !!
!!                                                               !!
!! USAGE: ./centos_aarch64_images.sh (7|8)                       !! 
!! ------------------------------------------------------------- !!"
  cd $PROJECT_DIR
  exit
fi

CENTOS_RELEASE=$1

if [ -e CentOS-$CENTOS_RELEASE-aarch64-GenericCloud.raw ]
  echo "CentOS image found.  Removing image."
  rm -rf Centos-$CENTOS_RELEASE-aarch64-GenericCloud.*
then
  echo "Proceeding to downloading CentOS $1 images."
  echo
fi

if [ $1 = "7" ]
then
  echo "Centos 7 Detected"
  export CENTOS_VERSION='1901'
  echo -n "Downloading, extracting, and converting:"
  wget -c http://cloud.centos.org/altarch/${CENTOS_RELEASE}/images/aarch64/CentOS-${CENTOS_RELEASE}-aarch64-GenericCloud-${CENTOS_VERSION}.qcow2.xz -O CentOS-${CENTOS_RELEASE}-aarch64-GenericCloud-${CENTOS_VERSION}.qcow2.xz
  unxz -v CentOS-$CENTOS_RELEASE-aarch64-GenericCloud-${CENTOS_VERSION}.qcow2.xz
  qemu-img convert -f qcow2 -O raw CentOS-${CENTOS_RELEASE}-aarch64-GenericCloud-${CENTOS_VERSION}.qcow2 CentOS-${CENTOS_RELEASE}-aarch64-GenericCloud-${CENTOS_VERSION}.raw
fi

if [ $1 = "8" ]
then
  echo "Centos 8 Detected"
  export CENTOS_VERSION='1.1911-20200113.3'
https://cloud.centos.org/centos/8/aarch64/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.aarch64.qcow2
  echo -n "Downloading and extracting inline:"
          https://cloud.centos.org/centos/8/aarch64/images/CentOS-8-GenericCloud-8.1.1911-20200113.3.aarch64.qcow2
  wget -c https://cloud.centos.org/centos/${CENTOS_RELEASE}/aarch64/images/CentOS-${CENTOS_RELEASE}-GenericCloud-${CENTOS_RELEASE}.${CENTOS_VERSION}.aarch64.qcow2 -O CentOS-${CENTOS_RELEASE}-GenericCloud-${CENTOS_RELEASE}.${CENTOS_VERSION}.aarch64.qcow2
  echo -n "Converting images."
  qemu-img convert -f qcow2 -O raw CentOS-${CENTOS_RELEASE}-GenericCloud-${CENTOS_RELEASE}.${CENTOS_VERSION}.aarch64.qcow2 CentOS-${CENTOS_RELEASE}-GenericCloud-${CENTOS_RELEASE}.${CENTOS_VERSION}.aarch64.raw
fi

cd $PROJECT_DIR
