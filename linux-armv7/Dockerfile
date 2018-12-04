FROM desertbit/crossbuild:base
MAINTAINER team@desertbit.com

ENV CROSS_TRIPLE=armv7-rpi2-linux-gnueabihf
ENV CROSS_ROOT=/home/builder/x-tools/${CROSS_TRIPLE}
ENV CROSS_SYSROOT=${CROSS_ROOT}/${CROSS_TRIPLE}/sysroot
ENV AS=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-as \
    AR=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-ar \
    CC=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-gcc \
    CPP=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-cpp \
    CXX=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-g++ \
    LD=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-ld \
    FC=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-gfortran

ENV PKG_CONFIG_PATH="${CROSS_SYSROOT}/lib/pkgconfig:${CROSS_SYSROOT}/usr/lib/pkgconfig"

ENV CGO_ENABLED=1
ENV GOOS=linux
ENV GOARCH=arm
ENV GOARM=7

ADD toolchain.cmake /etc/toolchain.cmake

RUN export NUM_CORES="$(grep -c processor /proc/cpuinfo)" && \
    sudo -H -u builder sh -c "ct-ng ${CROSS_TRIPLE} && ct-ng build.${NUM_CORES}" && \
    rm -rf "${CROSS_ROOT}"/build.log*

WORKDIR /work