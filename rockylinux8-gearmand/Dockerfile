FROM rockylinux:8 AS tmp-builder
RUN yum install -y epel-release
RUN yum install -y nodejs gearmand strace which rsync
RUN yum install -y findutils

RUN useradd -m app
WORKDIR /home/app
USER app

ADD . /home/app
RUN smith-strace/default-trace.sh $(which gearmand) --syslog --log-file stderr

USER root
RUN smith-strace/default-mkrootfs.sh
RUN tar --numeric-owner -C /rootfs -cvf rootfs.tar .

FROM scratch
COPY --from=tmp-builder /home/app/rootfs.tar /
