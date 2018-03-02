#!/bin/sh

set -e
set -x

apk add --no-cache curl
curl -XGET --unix-socket /var/run/docker.sock http://localhost/images/json
