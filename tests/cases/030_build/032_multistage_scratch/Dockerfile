FROM alpine:3.6 AS stage0
RUN touch /multi-scratch0

FROM alpine:3.6 AS stage1
RUN touch /multi-scratch1

FROM scratch
COPY --from=stage0 /multi-scratch0 /
COPY --from=stage1 /multi-scratch1 /
