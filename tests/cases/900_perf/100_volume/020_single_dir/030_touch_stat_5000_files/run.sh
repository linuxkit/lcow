#! /bin/sh

set -e
# don't set -x as it creates a lot of noise

DIR=$1

for i in $(seq 5000); do
    touch "$DIR/file-$i"
done

# find calls lstat()
find "$DIR" -type f > dev/null
