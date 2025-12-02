#!/bin/bash

server_base_dir="https://rcn-ee.net/rootfs"

device="am335x"
arch="armhf"
size="4gb"

date="2025-11-18"

debian_stable="13.2"
debian_old="12.12"

grab_image () {
	server_dir="debian-${arch}-13-base-${kernel_version}"
	file_prefix="${device}-debian-${debian_stable}-base-${kernel_version}-${arch}-${date}-${size}"

	wget -c --directory-prefix=/tmp/ ${server_base_dir}/${server_dir}/${date}/${file_prefix}.bmap
	if [ ! -f /tmp/${file_prefix}.bmap ] ; then
		echo "Failure to get ${server_base_dir}/${server_dir}/${date}/${file_prefix}.bmap"
		exit 2
	fi
	mv -v /tmp/${file_prefix}.bmap ../../bmap-temp/

	wget -c --directory-prefix=/tmp/ ${server_base_dir}/${server_dir}/${date}/${file_prefix}.img.xz.yml.txt
	mv -v /tmp/${file_prefix}.img.xz.yml.txt ${ymlfile}.yml

	server_dir="debian-${arch}-12-base-${kernel_version}"
	file_prefix="${device}-debian-${debian_old}-base-${kernel_version}-${arch}-${date}-${size}"

	wget -c --directory-prefix=/tmp/ ${server_base_dir}/${server_dir}/${date}/${file_prefix}.bmap
	if [ ! -f /tmp/${file_prefix}.bmap ] ; then
		echo "Failure to get ${server_base_dir}/${server_dir}/${date}/${file_prefix}.bmap"
		exit 2
	fi
	mv -v /tmp/${file_prefix}.bmap ../../bmap-temp/

	wget -c --directory-prefix=/tmp/ ${server_base_dir}/${server_dir}/${date}/${file_prefix}.img.xz.yml.txt
	mv -v /tmp/${file_prefix}.img.xz.yml.txt old-${ymlfile}.yml
}

kernel_version="v5.10-ti"
ymlfile="base-compat" ; grab_image

kernel_version="v6.12"
ymlfile="base-lts" ; grab_image

kernel_version="v6.17"
ymlfile="base-stable" ; grab_image
#
