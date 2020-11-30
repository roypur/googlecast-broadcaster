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

apt-get autoremove --purge iptables
apt-get autoremove --purge ifupdown
ln -s /usr/lib/systemd/system/nftables.service /etc/systemd/system/sysinit.target.wants/nftables.service

echo > /etc/NetworkManager/NetworkManager.conf
apt-get update
apt-get upgrade

rm -rf /var/cache
mkdir -p /var/cache
