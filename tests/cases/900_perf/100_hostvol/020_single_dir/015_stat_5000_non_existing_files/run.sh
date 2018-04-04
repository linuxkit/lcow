#! /bin/sh

# set -e
# don't set -x as it creates a lot of noise

DIR=$1

for i in $(seq 5000); do
    stat "$DIR/file-$i" 2> /dev/null
done
exit 0
