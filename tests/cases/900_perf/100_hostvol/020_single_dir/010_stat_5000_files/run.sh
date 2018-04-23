#! /bin/sh

set -e

DIR=$1

# find calls lstat()
find "$DIR" -type f > dev/null
