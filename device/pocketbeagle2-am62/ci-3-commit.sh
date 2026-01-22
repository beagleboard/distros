#!/bin/bash

. ci-version.sh
cd ../../
/bin/bash ./format_n_verify.sh
cd -
git add ../../bmap-temp/ || true
git add ./*.yml || true
git commit -a -m "${device}: ${debian_stable}-base/${debian_stable}-iot ${date}" -s
