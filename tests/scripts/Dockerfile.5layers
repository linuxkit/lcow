FROM alpine:3.7 AS build
RUN dd if=/dev/urandom of=file1 bs=128 count=1
RUN dd if=/dev/urandom of=file2 bs=128 count=1
RUN dd if=/dev/urandom of=file3 bs=128 count=1
RUN dd if=/dev/urandom of=file4 bs=128 count=1
RUN dd if=/dev/urandom of=file5 bs=128 count=1

FROM scratch
COPY --from=build /file1 /
COPY --from=build /file2 /
COPY --from=build /file3 /
COPY --from=build /file4 /
COPY --from=build /file5 /
