#!/bin/bash

if [ -f /usr/bin/jq ] ; then
	cat os_list.json | jq > os_list.json.bak
	mv os_list.json.bak os_list.json
fi

if [ -f /usr/bin/jsonlint-php ] ; then
	jsonlint-php os_list.json
fi
