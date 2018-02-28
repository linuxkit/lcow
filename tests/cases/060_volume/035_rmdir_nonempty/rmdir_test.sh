#!/bin/sh

set -e
set -x

DIR=$1

cd "$DIR" || exit 1
rm -rf foo
mkdir foo
touch foo/bar
(rmdir foo 2> output || true)
cat output
rm -rf foo
grep "Directory not empty" output
