#! /bin/sh

set -e

DIR=$1

# find calls lstat()
find "$DIR" -type f -print0 | xargs -0 touch > dev/null
find "$DIR" -type f > dev/null
