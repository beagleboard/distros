#!/bin/bash

server="https://rcn-ee.net/rootfs/"

device="am335x"
arch="armhf"
size="4gb"

date="2025-11-18"
r_compat="v5.10-ti"
r_lts="v6.12"
r_stable="v6.17"

grab_image () {
	image="13.2-base"
	wget -c --directory-prefix=/tmp/ ${server}debian-${arch}-13-base-${grab}/${date}/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap
	if [ ! -f /tmp/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap ] ; then
		echo "Failure to get ${server}debian-${arch}-13-base-${grab}/${date}/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap"
		exit 2
	fi
	mv -v /tmp/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap ../../bmap-temp/

	wget -c --directory-prefix=/tmp/ ${server}debian-${arch}-13-base-${grab}/${date}/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.img.xz.yml.txt
	mv -v /tmp/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.img.xz.yml.txt ${ymlfile}.yml

	image="12.12-base"
	wget -c --directory-prefix=/tmp/ ${server}debian-${arch}-12-base-${grab}/${date}/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap
	if [ ! -f /tmp/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap ] ; then
		echo "Failure to get ${server}debian-${arch}-12-base-${grab}/${date}/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap"
		exit 2
	fi
	mv -v /tmp/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap ../../bmap-temp/

	wget -c --directory-prefix=/tmp/ ${server}debian-${arch}-12-base-${grab}/${date}/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.img.xz.yml.txt
	mv -v /tmp/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.img.xz.yml.txt old-${ymlfile}.yml
}

ymlfile="base-compat" grab="${r_compat}" ; grab_image
ymlfile="base-lts" grab="${r_lts}" ; grab_image
ymlfile="base-stable" grab="${r_stable}" ; grab_image
