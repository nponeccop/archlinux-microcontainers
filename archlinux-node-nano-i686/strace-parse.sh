#!/usr/bin/env bash
set -ex -o pipefail
cat $1 \
	| sed -e 's|^[0-9]*  *||;' \
       	| grep -Ev '^[+\-]|= -1 E[A-Z]+ \([A-Z][A-Za-z ]+\)$' \
       	| sed -e 's|^open("\(.*\)", O_.* = [0-9]*$|\1|;s|^execve("\(.*\)", \[.*], 0x.* .*) = [0-9]*|\1|;s|^openat(AT_FDCWD, "\(.*\)", O_.*|\1|' | sort -u
