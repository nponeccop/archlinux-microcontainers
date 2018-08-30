#!/bin/bash

DIR=$(dirname $0)

timeout 5 strace -o app.trace -s 65536 -e trace=openat,execve -e signal=none -fyqq $* || true
$DIR/strace-spec.sh app.trace /
