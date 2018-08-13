#!/bin/bash
source /in_container/in_chroot/functions/functions.sh

cd /in_container

create_disk 8192

apt-get update
apt-get install -y debootstrap #debian-archive-keyring

_echo "Bootstrapping target OS"
. /etc/os-release
debootstrap $UBUNTU_CODENAME /target http://archive.ubuntu.com/ubuntu/

make_fstab
prepare_chroot

cp -rp /in_container/in_chroot /target
cp /etc/apt/sources.list /target/etc/apt/sources.list
chroot /target /in_chroot/build.sh

disk_clean

umount_disk

exit
