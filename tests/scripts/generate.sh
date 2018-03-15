#!/bin/sh

set -x
set -e

docker build --platform linux --no-cache \
       -t linuxkit/test-lcow:1layer -f Dockerfile.1layer .
docker push linuxkit/test-lcow:1layer

docker build --platform linux --no-cache \
       -t linuxkit/test-lcow:5layers -f Dockerfile.5layers .
docker push linuxkit/test-lcow:5layers

docker build --platform linux --no-cache \
       -t linuxkit/test-lcow:10layers -f Dockerfile.10layers .
docker push linuxkit/test-lcow:10layers

docker build --platform linux --no-cache \
       -t linuxkit/test-lcow:15layers -f Dockerfile.15layers .
docker push linuxkit/test-lcow:15layers

docker build --platform linux --no-cache \
       -t linuxkit/test-lcow:20layers -f Dockerfile.20layers .
docker push linuxkit/test-lcow:20layers
