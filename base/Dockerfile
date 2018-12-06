FROM ubuntu:18.04
MAINTAINER team@desertbit.com

ENV CT_PREFIX=/x-tools

# PATH setup.
# Ensure /scripts is always first.
ENV PATH="/scripts:$CT_PREFIX/bin:$GOROOT/bin:$PATH"
RUN echo 'export PATH="/scripts:$CT_PREFIX/bin:$GOROOT/bin:$PATH"' >> /etc/profile

# Set default compiler and linker flags.
ENV CPPFLAGS="-D_FORTIFY_SOURCE=2" \
    CFLAGS="-O2 -pipe -fstack-protector-strong -fno-plt" \
    CXXFLAGS="-O2 -pipe -fstack-protector-strong -fno-plt" \
    LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now"

# Install dependencies.
RUN apt-get -y update && \
    apt-get -y install \
        ca-certificates \
        build-essential autoconf autogen automake gcc g++ gperf bison flex texinfo help2man make \
        libncurses5-dev python-dev libtool libtool-bin patch libstdc++6 bzip2 xz-utils unzip gawk \
        openssl cmake ninja-build pkg-config \
        sudo git wget curl nano && \
    apt-get -y clean

# Setup cmake.
ADD toolchain.cmake /etc/toolchain.cmake

# Add scripts.
RUN mkdir /scripts
ADD cmake.sh /scripts/cmake
ADD ccmake.sh /scripts/ccmake
ADD build-toolchain.sh /scripts/build-toolchain
RUN chmod +x /scripts/cmake && \
    chmod +x /scripts/ccmake && \
    chmod +x /scripts/build-toolchain

# Install the Go compiler.
RUN export GO_VERSION="1.11.2" && \
    export GO_CHECKSUM="1dfe664fa3d8ad714bbd15a36627992effd150ddabd7523931f077b3926d736d" && \
    mkdir -p /tmp/go && \
    cd /tmp/go && \
    wget -O go.tar.gz https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz && \
    echo "${GO_CHECKSUM}  go.tar.gz" | sha256sum -c && \
    tar -xvf go.tar.gz && \
    mv go /usr/local && \
    rm -rf /tmp/go
ENV GOROOT=/usr/local/go \
    GOPATH=/work \
    CGO_ENABLED=1

# Install crosstool-NG.
RUN export CROSSTOOL_COMMIT="f8874f447e40852d33d65c1f443a90b0760901df" && \
    export NUM_CORES="$(grep -c processor /proc/cpuinfo)" && \
    mkdir -p /tmp/crosstool-ng && \
    cd /tmp/crosstool-ng && \
    git clone https://github.com/crosstool-ng/crosstool-ng.git && \
    cd crosstool-ng && \
    git checkout "${CROSSTOOL_COMMIT}" && \
    ./bootstrap && \
    ./configure --prefix=/usr && \
    make -j${NUM_CORES} && \
    make install && \
    rm -rf /tmp/crosstool-ng && \
    mkdir /x-tools

# Setup crosstool-NG user.
RUN groupadd -g 63339 ctng && \
    useradd -d /home/ctng -m -g 63339 -u 63339 -s /bin/bash ctng && \
    chown -R ctng:ctng "${CT_PREFIX}"

RUN mkdir /work
VOLUME /work
WORKDIR /work

ADD entrypoint.sh /scripts/entrypoint
RUN chmod +x /scripts/entrypoint
ENTRYPOINT ["/scripts/entrypoint"]