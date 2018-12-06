#!/usr/bin/env sh

exec /usr/bin/ccmake -DCMAKE_TOOLCHAIN_FILE:FILEPATH=/etc/toolchain.cmake "$@"