#! /bin/sh

set -e

DIR=$1
SIZE=$2

for i in $(seq 5000); do
    dd if=/dev/zero of="$DIR/file-$i" bs="$SIZE" count=1
done

for i in $(seq 5000); do
    dd if=/dev/zero of="$DIR/file-$i" bs="$SIZE" count=1
done
