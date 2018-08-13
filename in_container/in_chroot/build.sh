#!/bin/bash
source /in_chroot/functions/functions.sh

export DEBIAN_FRONTEND=noninteractive

_echo "Installing Linux kernel"
apt-get update
apt-get install -y linux-image-generic grub-pc dhcpcd5

DISK=$(cat /in_chroot/device)
_echo "Installing Linux boot loader (grub) to device $DISK"
grub-install $DISK
update-grub

set_password

enable_dhcp

_echo "Clean disk space"
apt-get clean
exit
