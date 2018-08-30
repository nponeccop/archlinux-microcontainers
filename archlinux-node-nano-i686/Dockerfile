FROM nponeccop/archlinux-microcontainers AS tmp-builder
ENV LANG=en_US.UTF-8
ENV HOSTTYPE=i686
RUN ln -s /usr/share/zoneinfo/UTC /etc/localtime
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
RUN setarch i686 pacman --noconfirm -Suy --needed npm strace rsync systemd && rm /var/cache/pacman/pkg/*.pkg.tar.xz
RUN useradd -m app
ADD . /home/app

WORKDIR /home/app
USER app
RUN setarch i686 npm install
RUN setarch i686 smith-strace/default-trace.sh node app

USER root
RUN setarch i686 smith-strace/default-mkrootfs.sh

FROM scratch
COPY --from=tmp-builder rootfs /
USER 1000
WORKDIR /home/app
ENTRYPOINT '/usr/bin/node'
CMD [ 'app' ]
