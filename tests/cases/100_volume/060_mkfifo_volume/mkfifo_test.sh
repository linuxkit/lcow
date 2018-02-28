#!/bin/sh

set -e
set -x

FILE=$1

mkfifo "$FILE"

TYPE=$(stat -c %F "$FILE")
if [ "$TYPE" != "fifo" ]; then
    echo "$FILE is not a fifo: $TYPE != fifo"
    exit 1
fi
