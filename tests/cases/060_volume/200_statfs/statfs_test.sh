#!/bin/sh

set -e
set -x

DIR=$1
ret=0

R=$(stat -f -c %t "$DIR")
if [ "$R" == "0" ]; then
   echo "Volume does not support reporting type"
   ret=1
fi

R=$(stat -f -c %s "$DIR")
if [ "$R" == "0" ]; then
   echo "Volume does not support reporting blocksize"
   ret=1
fi

R=$(stat -f -c %a "$DIR")
if [ "$R" == "0" ]; then
   echo "Volume does not support reporting blocksize"
   ret=1
fi

R=$(stat -f -c %b "$DIR")
if [ "$R" == "0" ]; then
   echo "Volume does not support reporting total data blocks"
   ret=1
fi

R=$(stat -f -c %c "$DIR")
if [ "$R" == "0" ]; then
   echo "Volume does not support reporting total file nodes"
   ret=1
fi

R=$(stat -f -c %d "$DIR")
if [ "$R" == "0" ]; then
   echo "Volume does not support reporting free file nodes"
   ret=1
fi

R=$(stat -f -c %f "$DIR")
if [ "$R" == "0" ]; then
   echo "Volume does not support reporting free blocks"
   ret=1
fi

R=$(stat -f -c %l "$DIR")
if [ "$R" == "0" ]; then
   echo "Volume does not support reporting maximum length of filenames"
   ret=1
fi

return $ret
