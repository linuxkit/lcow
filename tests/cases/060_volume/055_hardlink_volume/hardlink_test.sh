#!/bin/sh

set -e
set -x

FILE=$1
LINK=$2
CONTENT="foo"

echo "$CONTENT" > $FILE
ln "$FILE" "$LINK"

if [[ $(stat -c %h "$FILE") != $(stat -c %h "$LINK") ]]; then
    echo "Number of hardlinks don't match"
    exit 1
fi

if [[ $(stat -c %i "$FILE") != $(stat -c %i "$LINK") ]]; then
    echo "Inode numbers don't match"
    exit 1
fi

if [[ $(stat -c %h "$FILE") <= 1 ]]; then
    echo "$FILE should Number of hardlinks greater than 1"
    exit 1
fi

if [[ $(cat "$LINK") != "$CONTENT" ]]; then
    echo "Contents don't match"
    exit 1
fi
