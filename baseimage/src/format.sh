#!/usr/bin/env bash

export FIRMWARE_LOOP_DEV=$(losetup --find)
losetup ${FIRMWARE_LOOP_DEV} /disk/raw/disk-p1.img

export ROOT_LOOP_DEV=$(losetup --find)
losetup ${ROOT_LOOP_DEV} /disk/raw/disk-p2.img

mkfs -t vfat ${FIRMWARE_LOOP_DEV}
mkfs -t ext4 ${ROOT_LOOP_DEV}

export FIRMWARE_UUID=$(blkid --match-tag=UUID --output=value ${FIRMWARE_LOOP_DEV})
export ROOT_UUID=$(blkid --match-tag=UUID --output=value ${ROOT_LOOP_DEV})

echo FIRMWARE_UUID=${FIRMWARE_UUID}
echo ROOT_UUID=${ROOT_UUID}

sed --in-place "s/__ROOT_UUID__/${ROOT_UUID}/g" /disk/base-pre/etc/kernel/postinst.d/z60-raspi-firmware
sed --in-place "s/__ROOT_UUID__/${ROOT_UUID}/g" /disk/base-pre/etc/initramfs/post-update.d/z60-raspi-firmware

sed --in-place "s/__FIRMWARE_UUID__/${FIRMWARE_UUID}/g" /disk/base/etc/fstab
sed --in-place "s/__ROOT_UUID__/${ROOT_UUID}/g" /disk/base/etc/fstab
