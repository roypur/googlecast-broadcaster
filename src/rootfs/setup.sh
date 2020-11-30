#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade

apt-get install \
    linux-image-arm64 \
    raspi-firmware \
    avahi-daemon \
    network-manager \
    nftables

apt-get update
apt-get upgrade

rm -rf /var/cache
mkdir -p /var/cache
