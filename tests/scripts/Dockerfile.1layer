FROM alpine:3.7 AS build
RUN dd if=/dev/urandom of=file1 bs=128 count=1

FROM scratch
COPY --from=build /file1 /
