FROM linuxkit/alpine:86cd4f51b49fb9a078b50201d892a3c7973d48ec AS mirror
RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/
RUN apk add --no-cache --initdb -p /out \
    alpine-baselayout \
    busybox \
    e2fsprogs \
    musl
RUN rm -rf /out/etc/apk /out/lib/apk /out/var/cache

FROM linuxkit/alpine:86cd4f51b49fb9a078b50201d892a3c7973d48ec AS build
ENV OPENGCS_REPO=https://github.com/Microsoft/opengcs
ENV OPENGCS_COMMIT=fefd0ad73f6bfa33b8cce597be303e134fddc408
RUN apk add --no-cache build-base curl git go linux-headers musl-dev
ENV GOPATH=/go PATH=$PATH:/go/bin
RUN git clone $OPENGCS_REPO /go/src/github.com/Microsoft/opengcs && \
    cd /go/src/github.com/Microsoft/opengcs && \
    git checkout $OPENGCS_COMMIT && \
    make bin/init bin/vsockexec bin/gcs bin/gcstools && \
    cd bin && \
    for tool in vhd2tar exportSandbox netnscfg remotefs; do ln -s gcstools $tool; done
    
RUN mkdir -p /out/bin && \
    mkdir -p /out/sbin && \
    cp -r /go/src/github.com/Microsoft/opengcs/bin/* /out/bin && \
    mv /out/bin/init /out && \
    curl -fSL "https://raw.githubusercontent.com/mirror/busybox/38d966943f5288bb1f2e7219f50a92753c730b14/examples/udhcp/simple.script" -o /out/sbin/udhcpc_config.script && \
    chmod ugo+rx /out/sbin/udhcpc_config.script && \
    git -C /go/src/github.com/Microsoft/opengcs rev-parse HEAD > /out/gcs.commit && \
    git -C /go/src/github.com/Microsoft/opengcs rev-parse --abbrev-ref HEAD > /out/gcs.branch

FROM scratch
ENTRYPOINT []
CMD []
WORKDIR /
COPY --from=mirror /out/ /
COPY --from=build /out/ /
