FROM nponeccop/archlinux-pacstrap-i686 AS tmp-builder
RUN mkdir rootfs
ADD pacstrap base-needed /
RUN setarch i686 pacman -Suy haveged --noconfirm --needed
RUN haveged -w 1000
RUN setarch i686 ./pacstrap -c rootfs  $(cat base-needed)
RUN setarch i686 ./pacstrap -c rootfs util-linux pacman --needed
# RUN post-install.sh

FROM scratch
COPY --from=tmp-builder rootfs /



