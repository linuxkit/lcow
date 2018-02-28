#!/bin/sh

set -e
set -x

FILE=$1
LINK=$2
CONTENT="foo"

echo "$CONTENT" > $FILE
ln -s "$FILE" "$LINK"

if [[ $(readlink "$LINK") != "$FILE" ]]; then
    echo "Symlink $LINK is not pointing to $FILE"
    exit 1
fi

if [[ $(cat "$LINK") != "$CONTENT" ]]; then
    echo "Contents don't match"
    exit 1
fi
