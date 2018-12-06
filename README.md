# CrossBuild - Docker images for cross-compilation

**[Docker Hub](https://hub.docker.com/r/desertbit/crossbuild/tags/)**

- based on crosstool-NG (git master release)
- go compiler
- cmake
- ninja
- pkg-config
- build as user if the UID & GID environment variables are passed to docker

## Examples

```
docker run --rm \
    -v "${SRCDIR}":/work \
    desertbit/crossbuild:linux-armv7 \
    make all
```

```
docker run --rm \
    -v "${SRCDIR}":/work \
    desertbit/crossbuild:linux-armv7 \
    sh -c '$CC test.c -o test'
```

If we are running docker natively, we want to create a user in the container
with the same UID and GID as the user on the host machine, so that any files
created are owned by that user. Without this they are all owned by root.

```
docker run --rm \
    -e UID="$(id -u)" \
    -e GID="$(id -g)" \
    -v "${SRCDIR}":/work \
    desertbit/crossbuild:linux-armv7 \
    sh -c '$CC test.c -o test'
```

## Custom Libs

Install custom libs, sources and files to `${CROSS_SYSROOT}`.

## Credits

- [crosstool-NG](https://crosstool-ng.github.io/)
- [dockcross](https://github.com/dockcross/dockcross)