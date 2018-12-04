FROM ubuntu:16.04
MAINTAINER team@desertbit.com

# Ensure /scripts is always first.
ENV PATH="/scripts:$PATH"
RUN mkdir /scripts

RUN apt-get -y update && \
    apt-get -y install \
        ca-certificates \
        build-essential autoconf autogen gcc gperf bison flex texinfo help2man make \
        libncurses5-dev python-dev libtool-bin bzip2 xz-utils unzip gawk \
        openssl \
        sudo git wget curl nano && \
    apt-get -y clean

# Install cmake
RUN mkdir -p /tmp/cmake && \
    cd /tmp/cmake && \
    wget -O cmake.tar.gz https://www.cmake.org/files/v3.13/cmake-3.13.1.tar.gz && \
    echo "befe1ce6d672f2881350e94d4e3cc809697dd2c09e5b708b76c1dae74e1b2210  cmake.tar.gz" | sha256sum -c && \
    tar xf cmake.tar.gz && \
    cd cmake-3.13.1 && \
    ./configure && \
    make -j$(grep -c processor /proc/cpuinfo) && \
    make install && \
    rm -rf /tmp/cmake

# Setup cmake
ADD cmake.sh /scripts/cmake
RUN chmod +x /scripts/cmake
ENV CMAKE_TOOLCHAIN_FILE=/etc/toolchain.cmake

# Install ninja
RUN mkdir -p /tmp/ninja && \
    cd /tmp/ninja && \
    git clone git://github.com/ninja-build/ninja.git && \
    cd ninja && \
    git checkout release && \
    python ./configure.py --bootstrap && ./ninja && \
    cp ./ninja /usr/bin/ && \
    rm -rf /tmp/ninja

# Install the Go compiler
RUN mkdir -p /tmp/go && \
    cd /tmp/go && \
    wget -O go.tar.gz https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz && \
    echo "1dfe664fa3d8ad714bbd15a36627992effd150ddabd7523931f077b3926d736d  go.tar.gz" | sha256sum -c && \
    tar -xvf go.tar.gz && \
    mv go /usr/local && \
    rm -rf /tmp/go

# Go setup
ENV GOROOT=/usr/local/go
ENV PATH=$GOROOT/bin:$PATH
ENV GOPATH=/work

# Install crosstool-NG
RUN mkdir -p /tmp/crosstool-ng && \
    cd /tmp/crosstool-ng && \
    git clone https://github.com/crosstool-ng/crosstool-ng.git && \
    cd crosstool-ng && \
    ./bootstrap && \
    ./configure --prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info && \
    make && \
    make install && \
    rm -rf /tmp/crosstool-ng

RUN mkdir /work && \
    useradd -m -G users builder && \
    chown -R builder:builder /work

VOLUME /work
WORKDIR /work