#!/bin/bash
set -e -o pipefail
set -x

# mkdir rootfs
sudo pacstrap -c rootfs glibc archlinux-keyring --needed
sudo arch-chroot pacstrap-root sed -i 's|^#en_US.UTF-8|en_US.UTF-8|' /etc/locale.gen
sudo arch-chroot pacstrap-root locale-gen
sudo pacstrap -c rootfs arch-install-scripts --needed
sudo tar --numeric-owner -cv -C rootfs . | docker import -
