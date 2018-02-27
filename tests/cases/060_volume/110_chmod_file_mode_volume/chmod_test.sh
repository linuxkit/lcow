#!/bin/sh

set -e
set -x

# This script tests a number of combination of chmod of files. It does
# *not* error on the first error, instead all tests are run.

FILE=$1
CONTENT="foo"
ret=0

echo
TEST="chmod file r/w user only"
rm -rf "$FILE"
echo "CONTENT" > "$FILE"
chmod 0600 "$FILE"
RESULT=$(stat -c %a "$FILE")
EXPECTED="600"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chmod file r/x user only"
rm -rf "$FILE"
echo "CONTENT" > "$FILE"
chmod 0500 "$FILE"
RESULT=$(stat -c %a "$FILE")
EXPECTED="500"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chmod file r/w/x user r/x for group"
rm -rf "$FILE"
echo "CONTENT" > "$FILE"
chmod 0750 "$FILE"
RESULT=$(stat -c %a "$FILE")
EXPECTED="750"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chmod file r/w/x user r/x for group/other"
rm -rf "$FILE"
echo "CONTENT" > "$FILE"
chmod 0755 "$FILE"
RESULT=$(stat -c %a "$FILE")
EXPECTED="755"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chmod file setuid+r/w/x user r/x group/other"
rm -rf "$FILE"
echo "CONTENT" > "$FILE"
chmod 4755 "$FILE"
RESULT=$(stat -c %a "$FILE")
EXPECTED="4755"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chmod file setgid+r/w/x user r/x group/other"
rm -rf "$FILE"
echo "CONTENT" > "$FILE"
chmod 2755 "$FILE"
RESULT=$(stat -c %a "$FILE")
EXPECTED="2755"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

exit $ret
