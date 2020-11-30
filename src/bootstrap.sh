#!/usr/bin/env bash
qemu-debootstrap --arch arm64 bullseye /builder/newroot http://deb.debian.org/debian
cp /builder/rootfs/setup.sh /builder/newroot/setup.sh
rm -rf /builder/newroot/etc/apt/apt.conf.d
mkdir -p /builder/newroot/etc/apt/apt.conf.d

cp -rf /disk/base-pre/* /builder/newroot
chroot /builder/newroot /setup.sh
cp -rf /disk/base/* /builder/newroot
cp -rf /builder/rootfs/etc /builder/newroot
