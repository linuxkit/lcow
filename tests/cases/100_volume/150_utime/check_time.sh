#! /bin/sh

set -e
set -x

FILE=$1

ts=$(stat -c %Y "$FILE")
if [ "$ts" == "0" ]; then
    exit 0
fi
exit 1
