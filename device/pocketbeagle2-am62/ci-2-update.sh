#!/bin/bash

. ci-version.sh

server_base_dir="https://rcn-ee.net/rootfs"

arch="arm64"
size="8gb"

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

size="8gb"
kernel_version="v6.12"
server_dir="debian-${arch}-13-base-${kernel_version}-ti"
file_prefix="${device}-debian-${debian_stable}-base-${kernel_version}-${arch}-${date}-${size}"

ymlfile="base-stable" ; grab_image

kernel_version="v6.12"
server_dir="debian-${arch}-13-iot-${kernel_version}-ti"
file_prefix="${device}-debian-${debian_stable}-iot-${kernel_version}-${arch}-${date}-${size}"

ymlfile="iot-stable" ; grab_image

size="8gb"
kernel_version="v6.12"
server_dir="debian-${arch}-13-iot-${kernel_version}-ti"
file_prefix="${device}-workshop-debian-${debian_stable}-iot-${kernel_version}-${arch}-${date}-${size}"

ymlfile="workshop-stable" ; grab_image

size="8gb"
kernel_version="v6.18-k3"
server_dir="debian-${arch}-13-iot-${kernel_version}"
file_prefix="${device}-debian-${debian_stable}-iot-${kernel_version}-${arch}-${date}-${size}"

ymlfile="iot-lts-618" ; grab_image

size="8gb"
kernel_version="v6.18-k3"
server_dir="debian-${arch}-13-iot-${kernel_version}"
file_prefix="${device}-workshop-debian-${debian_stable}-iot-${kernel_version}-${arch}-${date}-${size}"

ymlfile="workshop-lts-618" ; grab_image
#
