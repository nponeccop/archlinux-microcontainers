#!/usr/bin/env bash
set -e -o pipefail

DIR=$(dirname $0)
IN=$1
ROOT=$2
TRACEFILE=app.trace

[ -d $2 ] || (echo "Argument $2 is not a dir" ; exit -1)

function strace_parse {
	cat \
		| sed -e 's|^[0-9]*  *||;' \
		| grep -Ev '^[+\-]|= -1 E[A-Z]+ \([A-Z][A-Za-z ]+\)$' \
		| sed -e 's|^open("\(.*\)", O_.* = [0-9]*$|\1|;s|^execve("\(.*\)", \[.*], 0x.* .*) = [0-9]*|\1|;s|^openat(AT_FDCWD, "\(.*\)", O_.*|\1|' | sort -u
}

function grep_nosys {
	grep -vE '^/(dev|sys|run|tmp|proc)/|^(/etc/ld.so.cache|/|/var/cache/ldconfig/aux-cache)$';
}

(
node $DIR/dir-links.js <(
	(
	cat $TRACEFILE | strace_parse | tee $IN
	find -L /lib -maxdepth 1 -name 'libnss_files.so*' -or -name 'libnss_dns.so*' -or -name 'ld-linux.so*' -or -name 'libresolv.so*'
	find -L /etc -maxdepth 1 -name 'hosts'
	) | grep_nosys
) $ROOT | grep_nosys

cat <<bar
/run
/dev
/sys
/tmp
/proc
/etc/resolv.conf
/lib
/mnt
/sbin
/usr/sbin
/srv
/opt
/bin
bar
) | sort -u
