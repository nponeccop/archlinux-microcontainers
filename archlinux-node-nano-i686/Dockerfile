FROM nponeccop/archlinux-microcontainers AS tmp-builder
ENV LANG=en_US.UTF-8
ENV HOSTTYPE=i686
RUN setarch i686 pacman --noconfirm -Suy --needed npm strace rsync && rm /var/cache/pacman/pkg/*.pkg.tar.xz && pacman -Scc --noconfirm
RUN useradd -m app
ADD . /home/app
WORKDIR /home/app
USER app
RUN setarch i686 npm install
RUN setarch i686 timeout 5 strace -o app.trace -s 65536 -e trace=openat,execve -e signal=none -fyqq node app.js || true
RUN cat app.trace | grep -v ENOENT
RUN ./strace-parse.sh app.trace >app.parsed
RUN ./strace-spec.sh app.parsed / >app.spec

USER root
RUN mkdir /rootfs
RUN rsync -alv / /rootfs --files-from=app.spec
RUN ls /rootfs/home -l
 

FROM scratch
COPY --from=tmp-builder rootfs /
WORKDIR /home/app
ENTRYPOINT [ '/usr/bin/node' ]
CMD [ '/home/app/app' ]

