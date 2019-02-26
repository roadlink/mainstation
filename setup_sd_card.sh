#! /bin/sh
cd /tmp
wget https://downloads.raspberrypi.org/raspbian_lite_latest
unzip raspbian_lite_latest
sudo fdisk -l
sudo dd if=/tmp/2018-11-13-raspbian-stretch-lite.img of=/dev/mmcblk0 bs=4M
