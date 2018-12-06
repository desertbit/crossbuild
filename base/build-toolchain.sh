#!/usr/bin/env sh

set -e

# These variables must be unset for ct-ng build.
unset CPPFLAGS CFLAGS CXXFLAGS LDFLAGS
unset AS AR CC CPP CXX LD FC 
unset PKG_CONFIG_PATH

NUM_CORES="$(grep -c processor /proc/cpuinfo)"
CROSS_ROOT="${CT_PREFIX}/${CROSS_TRIPLE}"

sudo -E -H -u ctng env "PATH=$PATH" sh << EOF
    set -e
    mkdir -p /tmp/ctng
    cd /tmp/ctng
    ct-ng ${CROSS_TRIPLE}
    ct-ng build.${NUM_CORES}
EOF

rm -rf /tmp/ctng
rm -rf "${CROSS_ROOT}"/build.log*

# Symlink so that binaries like strip are available.
ln -sf "${CROSS_ROOT}/${CROSS_TRIPLE}"/bin "${CT_PREFIX}"/bin
