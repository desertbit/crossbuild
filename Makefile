all: base-image linux-armv7-image linux-x86_64-image windows-x86_64-image

base-image:
	docker build base -t desertbit/crossbuild:base

linux-armv7-image:
	docker build linux-armv7 -t desertbit/crossbuild:linux-armv7

linux-x86_64-image:
	docker build linux-x86_64 -t desertbit/crossbuild:linux-x86_64

windows-x86_64-image:
	docker build windows-x86_64 -t desertbit/crossbuild:windows-x86_64