#!/bin/sh

ret=0

path=$1
bs=$2
count=$3

dd if=/dev/zero of="$path"/file0 bs="$bs" count="$count" &
pid0=$!

dd if=/dev/zero of="$path"/file1 bs="$bs" count="$count" &
pid1=$!

dd if=/dev/zero of="$path"/file2 bs="$bs" count="$count" &
pid2=$!

dd if=/dev/zero of="$path"/file3 bs="$bs" count="$count" &
pid3=$!

dd if=/dev/zero of="$path"/file4 bs="$bs" count="$count" &
pid4=$!

wait $pid0 || ret=1
wait $pid1 || ret=1
wait $pid2 || ret=1
wait $pid3 || ret=1
wait $pid4 || ret=1

exit $ret
