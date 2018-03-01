FROM alpine:3.7
RUN apk add --no-cache netcat-openbsd
COPY socket_test.sh /
RUN chmod ugo+x socket_test.sh
