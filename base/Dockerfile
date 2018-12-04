FROM ubuntu:18.04
MAINTAINER team@desertbit.com

# Ensure /scripts is always first.
ENV PATH="/scripts:$PATH"
RUN mkdir /scripts

RUN apt-get -y update && \
    apt-get -y install \
        ca-certificates \
        build-essential autoconf autogen gcc gperf bison flex texinfo help2man make \
        libncurses5-dev python-dev libtool-bin bzip2 xz-utils unzip gawk \
        openssl cmake ninja-build pkg-config \
        sudo git wget curl nano && \
    apt-get -y clean

# Setup cmake
ADD cmake.sh  /scripts/cmake
ADD ccmake.sh /scripts/ccmake
RUN chmod +x  /scripts/cmake && \
    chmod +x  /scripts/ccmake
ENV CMAKE_TOOLCHAIN_FILE=/etc/toolchain.cmake

# Install the Go compiler
RUN export GO_VERSION="1.11.2" && \
    export GO_CHECKSUM="1dfe664fa3d8ad714bbd15a36627992effd150ddabd7523931f077b3926d736d" && \
    mkdir -p /tmp/go && \
    cd /tmp/go && \
    wget -O go.tar.gz https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz && \
    echo "${GO_CHECKSUM}  go.tar.gz" | sha256sum -c && \
    tar -xvf go.tar.gz && \
    mv go /usr/local && \
    rm -rf /tmp/go

# Go setup
ENV GOROOT=/usr/local/go
ENV PATH=$GOROOT/bin:$PATH
ENV GOPATH=/work

# Install crosstool-NG
RUN export NUM_CORES="$(grep -c processor /proc/cpuinfo)" && \
    mkdir -p /tmp/crosstool-ng && \
    cd /tmp/crosstool-ng && \
    git clone https://github.com/crosstool-ng/crosstool-ng.git && \
    cd crosstool-ng && \
    ./bootstrap && \
    ./configure --prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info && \
    make -j${NUM_CORES} && \
    make install && \
    rm -rf /tmp/crosstool-ng

RUN mkdir /work && \
    useradd -m -G users builder && \
    chown -R builder:builder /work

VOLUME /work
WORKDIR /work