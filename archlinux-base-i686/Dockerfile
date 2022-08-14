FROM nponeccop/archlinux-pacstrap-i686:20220813 AS tmp-builder
RUN mkdir rootfs
ADD pacstrap base-needed /
RUN setarch i686 ./pacstrap -c rootfs archlinux{,32}-keyring
RUN setarch i686 ./pacstrap -c rootfs  $(cat base-needed)
RUN setarch i686 ./pacstrap -c rootfs util-linux pacman --needed
# RUN post-install.sh

FROM scratch
COPY --from=tmp-builder rootfs /



