#! /bin/sh

file=$1

# poll f0r 50 seconds for the file to appear
retries=50
while [ "${retries}" -ne 0 ]; do
    [ -f "$file" ] && exit 0
    sleep 1
    retries=$(( retries - 1 ))
done
exit 1
