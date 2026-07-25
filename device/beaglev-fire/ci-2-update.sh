#!/bin/bash

. ci-version.sh

server_base_dir="https://rcn-ee.net/rootfs"

bmap_base_dir="https://gitlab.com/beagle-rootfs/beaglev-fire-ubuntu/-/jobs"
yml__base_dir="https://beagle-rootfs.gitlab.io/-/beaglev-fire-ubuntu/-/jobs"
#ci_build
bmap_server_dir="artifacts/raw/deploy"
yml__server_dir="artifacts/deploy"

arch="arm64"

grab_image () {
	wget -c --directory-prefix=/tmp/ ${bmap_base_dir}/${ci_build}/${bmap_server_dir}/${file_prefix}.bmap
	if [ ! -f /tmp/${file_prefix}.bmap ] ; then
		echo "Failure to get ${bmap_base_dir}/${ci_build}/${bmap_server_dir}/${file_prefix}.bmap"
		exit 2
	fi
	mv -v /tmp/${file_prefix}.bmap ../../bmap-temp/

	wget -c --directory-prefix=/tmp/ ${yml__base_dir}/${ci_build}/${yml__server_dir}/${file_prefix}.img.xz.yml.txt
	if [ ! -f /tmp/${file_prefix}.img.xz.yml.txt ] ; then
		echo "Failure to get ${yml__base_dir}/${ci_build}/${yml__server_dir}/${file_prefix}.img.xz.yml.txt"
		exit 2
	fi
	mv -v /tmp/${file_prefix}.img.xz.yml.txt ${ymlfile}.yml
}

file_prefix="beaglev-fire-debian-13-iot-v6.12-riscv64-${date}-4gb"

ymlfile="iot-stable" ; grab_image

#
