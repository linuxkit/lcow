#!/bin/sh

set -e
set -x

# This script tests a number of combination of chown of files. It does
# *not* error on the first error, instead all tests are run.

FILE=$1
ret=0

echo
TEST="chown file uid only (nobody)"
rm -rf "$FILE"
touch "$FILE"
chown nobody "$FILE"
RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
EXPECTED="nobody:root"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chown file uid only (postgres)"
rm -rf "$FILE"
touch "$FILE"
chown postgres "$FILE"
RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
EXPECTED="postgres:root"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chown file uid only (root)"
rm -rf "$FILE"
touch "$FILE"
chown root "$FILE"
RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
EXPECTED="root:root"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chown file gid only (nobody)"
rm -rf "$FILE"
touch "$FILE"
chown :nobody "$FILE"
RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
EXPECTED="root:nobody"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chown file gid only (postgres)"
rm -rf "$FILE"
touch "$FILE"
chown :postgres "$FILE"
RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
EXPECTED="root:postgres"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chown file gid only (root)"
rm -rf "$FILE"
touch "$FILE"
chown :root "$FILE"
RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
EXPECTED="root:root"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chown file uid and gid (nobody)"
rm -rf "$FILE"
touch "$FILE"
chown nobody:nobody "$FILE"
RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
EXPECTED="nobody:nobody"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chown file uid and gid (postgres)"
rm -rf "$FILE"
touch "$FILE"
chown postgres:postgres "$FILE"
RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
EXPECTED="postgres:postgres"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

echo
TEST="chown file uid and gid (root)"
rm -rf "$FILE"
touch "$FILE"
chown root:root "$FILE"
RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
EXPECTED="root:root"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi

exit $ret
