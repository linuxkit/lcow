.PHONY: build
build: lcow.yml Makefile
	moby build lcow.yml
	mv lcow-kernel bootx64.efi
	mv lcow-initrd.img initrd.img
bootx64.efi: build
initrd.img: build

.PHONY: release
release: release.zip
release.zip: bootx64.efi initrd.img versions.txt
	zip $@ bootx64.efi initrd.img versions.txt

versions.txt:
	moby version > $@
	linuxkit version >> $@
	git rev-list -1 HEAD >> $@

clean:
	rm -f lcow-initrd.img lcow-kernel lcow-cmdline versions.txt release.zip
