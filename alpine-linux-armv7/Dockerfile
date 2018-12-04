FROM desertbit/crossbuild:alpine-base
MAINTAINER team@desertbit.com

ADD crosstool.config /work/crosstool.config
RUN mkdir -p /usr/share/crosstool-ng/samples/armv7-unknown-linux-musleabi && \
    mv /work/crosstool.config /usr/share/crosstool-ng/samples/armv7-unknown-linux-musleabi/crosstool.config

USER builder
RUN mkdir -p /work/crosstool && \
    cd /work/crosstool && \
    ct-ng armv7-unknown-linux-musleabi && \
    ct-ng build.12
