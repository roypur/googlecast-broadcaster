#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive
chmod -R 755 /builder

rm -rf /etc/apt/apt.conf.d
mkdir -p /etc/apt/apt.conf.d
mkdir -p /disk/base-pre/etc/apt/apt.conf.d
cp /builder/50-headless.conf /etc/apt/apt.conf.d/50-headless.conf
cp /builder/50-headless.conf /disk/base-pre/etc/apt/apt.conf.d/50-headless.conf
cp /builder/sources.list /disk/base-pre/etc/apt/sources.list
cp /builder/sources.list /etc/apt/sources.list

apt-get update
apt-get install qemu-user-static binfmt-support dosfstools debootstrap util-linux fdisk python3
apt-get upgrade

dd if=/dev/zero of=/builder/disk.img bs=1M count=3075
cat /builder/sfdisk.dump | sfdisk /builder/disk.img

/builder/network.py

mkdir -p /disk/raw
dd if=/builder/disk.img of=/disk/raw/disk-mbr.img ibs=512 count=2048
dd if=/dev/zero of=/disk/raw/disk-gap.img ibs=512 count=2048
dd if=/dev/zero of=/disk/raw/disk-p1.img ibs=512 count=1048576
dd if=/dev/zero of=/disk/raw/disk-p2.img ibs=512 count=5242880
chmod -R 755 /disk
chmod -R 600 /disk/base-pre/etc/NetworkManager/system-connections/*

rm -rf /builder
rm -rf /var/cache
mkdir -p /var/cache
