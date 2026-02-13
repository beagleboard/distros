#!/bin/bash

. ci-version.sh

server_base_dir="https://rcn-ee.net/rootfs"

arch="armhf"
size="4gb"

grab_trixie () {
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
}

grab_bookworm () {
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

grab_image () {
	grab_trixie
	grab_bookworm
}

kernel_version="v5.10-ti"
ymlfile="base-compat" ; grab_image

kernel_version="v6.12"
ymlfile="base-lts-612" ; grab_image

kernel_version="v6.18"
ymlfile="base-lts-618" ; grab_image

kernel_version="v6.19"
ymlfile="base-stable" ; grab_trixie

#
