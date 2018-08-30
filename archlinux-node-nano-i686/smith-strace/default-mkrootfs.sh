#!/bin/bash

mkdir /rootfs
rsync -alv / /rootfs --files-from=app.spec
