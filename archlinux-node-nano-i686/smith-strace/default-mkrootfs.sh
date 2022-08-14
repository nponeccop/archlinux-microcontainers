#!/bin/bash

mkdir /rootfs
rsync -alv / /rootfs --files-from=app.spec
tar --numeric-owner -C /rootfs -cvf /rootfs.tar .
