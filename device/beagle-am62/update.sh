#!/bin/bash

server_base_dir="https://rcn-ee.net/rootfs"

device="beagleplay"
arch="arm64"
size="12gb"

date="2025-12-02"

debian_stable="13.2"

grab_image () {
	wget -c --directory-prefix=/tmp/ ${server_base_dir}/${server_dir}/${date}/${file_prefix}.bmap
	if [ ! -f /tmp/${file_prefix}.bmap ] ; then
		echo "Failure to get ${server_base_dir}/${server_dir}/${date}/${file_prefix}.bmap"
		exit 2
	fi
	mv -v /tmp/${file_prefix}.bmap ../../bmap-temp/

	wget -c --directory-prefix=/tmp/ ${server_base_dir}/${server_dir}/${date}/${file_prefix}.img.xz.yml.txt
	if [ ! -f /tmp/${file_prefix}.img.xz.yml.txt ] ; then
		echo "Failure to get ${server_base_dir}/${server_dir}/${date}/${file_prefix}.img.xz.yml.txt"
		exit 2
	fi
	mv -v /tmp/${file_prefix}.img.xz.yml.txt ${ymlfile}.yml
}

size="12gb"
kernel_version="v6.12"
server_dir="debian-${arch}-13-xfce-${kernel_version}-ti"
file_prefix="${device}-debian-${debian_stable}-xfce-${kernel_version}-${arch}-${date}-${size}"

ymlfile="xfce-stable" ; grab_image

device="beagleplay-emmc-flasher"
file_prefix="${device}-debian-${debian_stable}-xfce-${kernel_version}-${arch}-${date}-${size}"
ymlfile="flasher-xfce-stable" ; grab_image

device="beagleplay"
size="8gb"
kernel_version="v6.12"
server_dir="debian-${arch}-13-base-${kernel_version}-ti"
file_prefix="${device}-debian-${debian_stable}-base-${kernel_version}-${arch}-${date}-${size}"

ymlfile="base-stable" ; grab_image

device="beagleplay-emmc-flasher"
file_prefix="${device}-debian-${debian_stable}-base-${kernel_version}-${arch}-${date}-${size}"
ymlfile="flasher-base-stable" ; grab_image
#
