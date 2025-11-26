#!/bin/bash

server="https://rcn-ee.net/rootfs/"

device="beagley-ai"
arch="arm64"
size="12gb"

date="2025-11-25"
r_stable="v6.1-ti"
r_image="13-xfce-v6.1-ti"

grab_image () {
	wget -c --directory-prefix=/tmp/ ${server}debian-${arch}-${r_image}/${date}/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap
	if [ ! -f /tmp/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap ] ; then
		echo "Failure to get ${server}debian-${arch}-${r_image}/${date}/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap"
		exit 2
	fi
	mv -v /tmp/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.bmap ../../bmap-temp/

	wget -c --directory-prefix=/tmp/ ${server}debian-${arch}-${r_image}/${date}/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.img.xz.yml.txt
	if [ ! -f /tmp/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.img.xz.yml.txt ] ; then
		echo "Failure to get ${server}debian-${arch}-${r_image}/${date}/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.img.xz.yml.txt"
		exit 2
	fi
	mv -v /tmp/${device}-debian-${image}-${grab}-${arch}-${date}-${size}.img.xz.yml.txt ${ymlfile}.yml
}

image="13.2-xfce"
ymlfile="xfce-stable" grab="v6.1" ; grab_image

size="8gb"
r_image="13-base-v6.1-ti"
image="13.2-base"

ymlfile="base-stable" grab="v6.1" ; grab_image

size="12gb"
r_image="13-xfce-v6.12-ti"
image="13.2-xfce"
ymlfile="test-xfce-v6.12.x" grab="v6.12" ; grab_image
