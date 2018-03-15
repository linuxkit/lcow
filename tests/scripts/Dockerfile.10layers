FROM alpine:3.7 AS build
RUN dd if=/dev/urandom of=file01 bs=128 count=1
RUN dd if=/dev/urandom of=file02 bs=128 count=1
RUN dd if=/dev/urandom of=file03 bs=128 count=1
RUN dd if=/dev/urandom of=file04 bs=128 count=1
RUN dd if=/dev/urandom of=file05 bs=128 count=1

RUN dd if=/dev/urandom of=file06 bs=128 count=1
RUN dd if=/dev/urandom of=file07 bs=128 count=1
RUN dd if=/dev/urandom of=file08 bs=128 count=1
RUN dd if=/dev/urandom of=file09 bs=128 count=1
RUN dd if=/dev/urandom of=file10 bs=128 count=1

FROM scratch
COPY --from=build /file01 /
COPY --from=build /file02 /
COPY --from=build /file03 /
COPY --from=build /file04 /
COPY --from=build /file05 /

COPY --from=build /file06 /
COPY --from=build /file07 /
COPY --from=build /file08 /
COPY --from=build /file09 /
COPY --from=build /file10 /
