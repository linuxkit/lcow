FROM alpine:3.6 AS stage0
RUN touch /multi0

FROM alpine:3.6 AS stage1
RUN touch /multi1

FROM alpine:3.6
COPY --from=stage0 /multi0 /
COPY --from=stage1 /multi1 /
