#!/bin/bash

run_id () {
	cat ./device/${device}/id.yml | sed 's/^/    /' >> ./id.yml
	echo "" >> ./id.yml
}

run_img () {
	if [ -f ./device/${device}/xfce-stable.yml ] ; then
		cat ./device/${device}/xfce-stable.yml | sed 's/^/  /' >> ./id.yml
		echo "" >> ./id.yml
	fi

	if [ -f ./device/${device}/xfce-v6.12.x.yml ] ; then
		cat ./device/${device}/xfce-v6.12.x.yml | sed 's/^/  /' >> ./id.yml
		echo "" >> ./id.yml
	fi

	if [ -f ./device/${device}/xfce-v6.6.x.yml ] ; then
		cat ./device/${device}/xfce-v6.6.x.yml | sed 's/^/  /' >> ./id.yml
		echo "" >> ./id.yml
	fi

	if [ -f ./device/${device}/xfce-v6.1.x.yml ] ; then
		cat ./device/${device}/xfce-v6.1.x.yml | sed 's/^/  /' >> ./id.yml
		echo "" >> ./id.yml
	fi

	if [ -f ./device/${device}/iot-v6.12.x.yml ] ; then
		cat ./device/${device}/iot-v6.12.x.yml | sed 's/^/  /' >> ./id.yml
		echo "" >> ./id.yml
	fi

	if [ -f ./device/${device}/debian-13-iot-v6.12.x.yml ] ; then
		cat ./device/${device}/debian-13-iot-v6.12.x.yml | sed 's/^/  /' >> ./id.yml
		echo "" >> ./id.yml
	fi

	if [ -f ./device/${device}/base-lts.yml ] ; then
		cat ./device/${device}/base-lts.yml | sed 's/^/  /' >> ./id.yml
		echo "" >> ./id.yml
	fi

	if [ -f ./device/${device}/base-stable.yml ] ; then
		cat ./device/${device}/base-stable.yml | sed 's/^/  /' >> ./id.yml
		echo "" >> ./id.yml
	fi

	if [ -f ./device/${device}/base-v6.12.x.yml ] ; then
		cat ./device/${device}/base-v6.12.x.yml | sed 's/^/  /' >> ./id.yml
		echo "" >> ./id.yml
	fi
	if [ -f ./device/${device}/base-v6.6.x.yml ] ; then
		cat ./device/${device}/base-v6.6.x.yml | sed 's/^/  /' >> ./id.yml
		echo "" >> ./id.yml
	fi
	if [ -f ./device/${device}/base-v6.1.x.yml ] ; then
		cat ./device/${device}/base-v6.1.x.yml | sed 's/^/  /' >> ./id.yml
		echo "" >> ./id.yml
	fi
}

run_flasher_img () {
	if [ -f ./device/${device}/flasher-xfce-stable.yml ] ; then
		cat ./device/${device}/flasher-xfce-stable.yml | sed 's/^/    /' >> ./id.yml
		echo "" >> ./id.yml
	fi

	if [ -f ./device/${device}/flasher-xfce-v6.12.x.yml ] ; then
		cat ./device/${device}/flasher-xfce-v6.12.x.yml | sed 's/^/    /' >> ./id.yml
		echo "" >> ./id.yml
	fi
	if [ -f ./device/${device}/flasher-xfce-v6.6.x.yml ] ; then
		cat ./device/${device}/flasher-xfce-v6.6.x.yml | sed 's/^/    /' >> ./id.yml
		echo "" >> ./id.yml
	fi
	if [ -f ./device/${device}/flasher-xfce-v6.1.x.yml ] ; then
		cat ./device/${device}/flasher-xfce-v6.1.x.yml | sed 's/^/    /' >> ./id.yml
		echo "" >> ./id.yml
	fi

	if [ -f ./device/${device}/flasher-base-stable.yml ] ; then
		cat ./device/${device}/flasher-base-stable.yml | sed 's/^/    /' >> ./id.yml
		echo "" >> ./id.yml
	fi

	if [ -f ./device/${device}/flasher-base-v6.12.x.yml ] ; then
		cat ./device/${device}/flasher-base-v6.12.x.yml | sed 's/^/    /' >> ./id.yml
		echo "" >> ./id.yml
	fi
	if [ -f ./device/${device}/flasher-base-v6.6.x.yml ] ; then
		cat ./device/${device}/flasher-base-v6.6.x.yml | sed 's/^/    /' >> ./id.yml
		echo "" >> ./id.yml
	fi
	if [ -f ./device/${device}/flasher-base-v6.1.x.yml ] ; then
		cat ./device/${device}/flasher-base-v6.1.x.yml | sed 's/^/    /' >> ./id.yml
		echo "" >> ./id.yml
	fi
}

run_test_img () {
	if [ -f ./device/${device}/test-xfce-v6.12.x.yml ] ; then
		cat ./device/${device}/test-xfce-v6.12.x.yml | sed 's/^/    /' >> ./id.yml
		echo "" >> ./id.yml
	fi
	if [ -f ./device/${device}/test-xfce-v6.6.x.yml ] ; then
		cat ./device/${device}/test-xfce-v6.6.x.yml | sed 's/^/    /' >> ./id.yml
		echo "" >> ./id.yml
	fi
}

if [ ! -f /usr/bin/jq ] ; then
	echo "jq binary missing"
	exit 2
fi

if [ ! -f /usr/bin/yq ] ; then
	echo "yq binary missing"
	exit 2
fi

cat ./device/static/id_header.yml > ./id.yml

device="beagle-am67" ; run_id
device="beagle-am62" ; run_id
device="pocketbeagle2-am62" ; run_id
device="beagle-tda4vm" ; run_id
device="beaglev-fire" ; run_id
device="beagle-am335" ; run_id

echo "os_list:" >> ./id.yml

device="beagle-am67" ; run_img
device="beagle-am62" ; run_img
device="pocketbeagle2-am62" ; run_img
device="beagle-tda4vm" ; run_img
device="beagle-am335" ; run_img

echo "  - name: eMMC Flashing (other)" >> ./id.yml
echo "    description: These images will Flash the onboard eMMC on first bootup" >> ./id.yml
echo "    icon: https://www.beagleboard.org/app/uploads/2022/10/debian.png" >> ./id.yml
echo "    subitems:" >> ./id.yml

device="beagle-am62" ; run_flasher_img
device="beagle-tda4vm" ; run_flasher_img

echo "  - name: Testing Images (other)" >> ./id.yml
echo "    description: Here be Dragons, images for testing!!!" >> ./id.yml
echo "    icon: https://www.beagleboard.org/app/uploads/2022/10/debian.png" >> ./id.yml
echo "    subitems:" >> ./id.yml

device="beagle-am67" ; run_test_img

if [ -f /usr/bin/yq ] ; then
	cat ./id.yml | yq > os_list.json
fi
rm ./id.yml

if [ -f /usr/bin/jq ] ; then
	cat os_list.json | jq > os_list.json.bak
	mv os_list.json.bak os_list.json
fi

if [ -f /usr/bin/jsonlint-php ] ; then
	jsonlint-php os_list.json
fi
