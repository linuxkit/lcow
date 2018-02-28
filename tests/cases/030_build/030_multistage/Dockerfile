FROM alpine:3.7 AS stage0
RUN touch /multi0

FROM alpine:3.7 AS stage1
RUN touch /multi1

FROM alpine:3.7
COPY --from=stage0 /multi0 /
COPY --from=stage1 /multi1 /
