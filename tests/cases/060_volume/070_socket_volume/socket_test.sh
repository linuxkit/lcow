#!/bin/sh

set -e
set -x

FILE=$1

nc -lU "$FILE" &
pid=$!

sleep 1

TYPE=$(stat -c %F "$FILE")

kill "$pid"

if [ "$TYPE" != "socket" ]; then
    echo "$FILE is not a unix domain socket: $TYPE != socket"
    exit 1
fi
