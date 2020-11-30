#!/usr/bin/env bash

umount ${FIRMWARE_LOOP_DEV}
umount ${ROOT_LOOP_DEV}

losetup --detach=${FIRMWARE_LOOP_DEV}
losetup --detach=${ROOT_LOOP_DEV}

mkdir -p /out
cat /disk/raw/disk-mbr.img /disk/raw/disk-p1.img /disk/raw/disk-gap.img /disk/raw/disk-p2.img > /out/debian.img
