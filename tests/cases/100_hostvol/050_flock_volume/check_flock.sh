#! /bin/sh

set -e
set -x

FILE=$1
ret=0

# First check that flock works
flock -x "$FILE" echo "flock works"

# disable exit on error as we expect an error below
set +e

# start a background process locking a file
flock -x "$FILE" sleep 1000 &
pid=$!

# try to lock the file
flock -xn "$FILE" echo "locked although locked"
res=$?
[ $res -eq 0 ] && $ret = 1 # If we did not get an error this test failed

# clean up
kill $pid
flock -u "$FILE" echo "unlocked"

exit $ret
