CROSSBUILD_IMAGES = linux-armv7 linux-x86_64 windows-x86_64

$(CROSSBUILD_IMAGES): %:
	awk '/import common.toolchain/{system("cat common/toolchain");next}1' $@/Dockerfile.in > $@/Dockerfile
	docker build $@ -t desertbit/crossbuild:$@
	rm -f $@/Dockerfile

base:
	docker build base -t desertbit/crossbuild:base

menuconfig:
	docker run --rm -it desertbit/crossbuild:base ct-ng menuconfig

.PHONY: $(CROSSBUILD_IMAGES) base menuconfig