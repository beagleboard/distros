#!/bin/bash

. ci-version.sh

server_base_dir="https://rcn-ee.net/rootfs"

arch="arm64"

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
	sed -i -e 's:distros/refs/heads/main/sbom-temp:sbom-archive/refs/heads/main/sbom:g' ${ymlfile}.yml

	wget -c --directory-prefix=/tmp/ ${server_base_dir}/${server_dir}/${date}/${file_prefix}.syft.spdx.json.xz
	if [ ! -f /tmp/${file_prefix}.syft.spdx.json.xz ] ; then
		echo "Failure to get ${server_base_dir}/${server_dir}/${date}/${file_prefix}.syft.spdx.json.xz"
		exit 2
	fi
	mv -v /tmp/${file_prefix}.syft.spdx.json.xz ../../../sbom-archive/sbom/
}

size="10gb"
kernel_version="v7.2-k3"
server_dir="debian-${arch}-13-iot-${kernel_version}"
file_prefix="${device}-debian-${debian_stable}-iot-${kernel_version}-${arch}-${date}-${size}"

ymlfile="iot-stable" ; grab_image

size="12gb"
kernel_version="v7.2-k3"
server_dir="debian-${arch}-13-xfce-${kernel_version}"
file_prefix="${device}-debian-${debian_stable}-xfce-${kernel_version}-${arch}-${date}-${size}"

ymlfile="xfce-stable" ; grab_image

#
