.PHONY: build
build: lcow.yml Makefile
	linuxkit build lcow.yml
	mv lcow-kernel kernel
	mv lcow-initrd.img initrd.img
kernel: build
initrd.img: build

.PHONY: release
release: release.zip
release.zip: kernel initrd.img versions.txt
	zip $@ kernel initrd.img versions.txt

versions.txt:
	linuxkit version >> $@
	git rev-list -1 HEAD >> $@

clean:
	rm -f lcow-initrd.img lcow-kernel lcow-cmdline versions.txt release.zip
