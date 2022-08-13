#!/bin/bash
set -ex -o pipefail
podman build . -t small-tar -f Dockerfile.node
podman rm small-tar || true
podman create --name small-tar small-tar /bin/dummycmd
podman cp small-tar:/rootfs.tar rootfs.tar
podman rm small-tar || true

