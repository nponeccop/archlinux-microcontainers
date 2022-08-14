#!/bin/bash

timeout 5 strace -o app.trace -s 65536 -e trace=openat,execve -e signal=none -fyqq $* || true
