#!/bin/bash

. ci-version.sh
cd ../../
/bin/bash ./format_n_verify.sh
cd -
git add ../../bmap-temp/
git commit -a -m "${device}: ${debian_stable}-base/${debian_old}-base ${date}" -s
