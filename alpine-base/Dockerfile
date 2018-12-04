FROM alpine:3.8
MAINTAINER team@desertbit.com

RUN apk update && \
    apk upgrade && \
    apk add \
        git alpine-sdk build-base \
        bash gawk bison flex automake autoconf libtool cvs texinfo gperf \
        ncurses-dev gettext-dev libc-dev help2man xz sed unzip python wget gawk

RUN mkdir -p /tmp/crosstool-ng && \
    cd /tmp/crosstool-ng && \
    git clone https://github.com/crosstool-ng/crosstool-ng.git && \
    cd crosstool-ng && \
    export LDFLAGS=-lintl && \
    ./bootstrap && \
    ./configure --prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info && \
    make && \
    make install && \
    rm -rf /tmp/crosstool-ng

RUN mkdir /work && mkdir -p /home/builder && \
    addgroup -g 1001 builder && \
    adduser -u 1001 -G builder -h /home/builder -s /bin/sh -D builder && \
    chown -R builder:builder /work

VOLUME /work
WORKDIR /work