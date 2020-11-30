#!/usr/bin/env bash
chown -R root:root /builder
chmod -R 755 /builder
chown -R root:root /disk
chmod -R 755 /disk

source /disk/format.sh
update-binfmts --enable

rm -rf /builder/newroot
mkdir -p /builder/newroot
mount ${ROOT_LOOP_DEV} /builder/newroot

mkdir -p /builder/newroot/boot/firmware
mount ${FIRMWARE_LOOP_DEV} /builder/newroot/boot/firmware

/builder/bootstrap.sh

update-binfmts --disable
/disk/finish.sh
