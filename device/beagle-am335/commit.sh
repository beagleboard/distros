#!/bin/bash

. version.sh

git add ../../bmap-temp/
git commit -a -m '${device}: ${debian_stable}-base/${debian_old}-base ${date}' -s
