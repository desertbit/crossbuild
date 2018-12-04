FROM desertbit/crossbuild:base
MAINTAINER team@desertbit.com

RUN sudo -H -u builder sh -c "ct-ng x86_64-ubuntu16.04-linux-gnu && ct-ng build.$(grep -c processor /proc/cpuinfo)" && \
    rm -rf /home/builder/x-tools/x86_64-ubuntu16.04-linux-gnu/build.log*

ENV CROSS_TRIPLE=x86_64-ubuntu16.04-linux-gnu
ENV CROSS_ROOT=/home/builder/x-tools/${CROSS_TRIPLE}
ENV AS=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-as \
    AR=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-ar \
    CC=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-gcc \
    CPP=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-cpp \
    CXX=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-g++ \
    LD=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-ld \
    FC=${CROSS_ROOT}/bin/${CROSS_TRIPLE}-gfortran

ENV CGO_ENABLED=1
ENV GOOS=linux
ENV GOARCH=amd64