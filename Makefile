IMAGES = base linux-armv7 linux-x86_64 windows-x86_64

$(IMAGES): %:
	docker build $@ -t desertbit/crossbuild:$@

.PHONY: $(IMAGES)