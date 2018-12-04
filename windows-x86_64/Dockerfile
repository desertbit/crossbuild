FROM desertbit/crossbuild:base
MAINTAINER team@desertbit.com

ENV CROSS_TRIPLE=x86_64-w64-mingw32
ENV CROSS_ROOT=/home/builder/x-tools/${CROSS_TRIPLE}
ENV AS=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-as \
    AR=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-ar \
    CC=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-gcc \
    CPP=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-cpp \
    CXX=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-g++ \
    LD=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-ld \
    FC=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-gfortran

ENV CGO_ENABLED=1
ENV GOOS=windows
ENV GOARCH=amd64

ADD toolchain.cmake /etc/toolchain.cmake

RUN export NUM_CORES="$(grep -c processor /proc/cpuinfo)" && \
    sudo -H -u builder sh -c "ct-ng ${CROSS_TRIPLE} && ct-ng build.${NUM_CORES}" && \
    rm -rf "${CROSS_ROOT}"/build.log*

WORKDIR /work