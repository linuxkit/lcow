#!/bin/sh

set -e
set -x

# This script tests a number of combination of chown of symlink. It does
# *not* error on the first error, instead all tests are run.

FILE=$1
LINK=$2
ret=0

touch "$FILE"
# We use 'chown -h' below so expect only the symlink but not
# the real file to change.
FILE_EXPECTED=$(su -c "stat -c %U:%G $FILE" postgres)

echo
TEST="chown symlink uid only (nobody)"
rm -rf "$LINK"
ln -s "$FILE" "$LINK"
chown -h nobody "$LINK"
RESULT=$(su -c "stat -c %U:%G $LINK" postgres)
EXPECTED="nobody:root"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi
FILE_RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
if [ "$FILE_EXPECTED" != "$FILE_RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT on real file"
    ret=1
fi

echo
TEST="chown symlink uid only (postgres)"
rm -rf "$LINK"
ln -s "$FILE" "$LINK"
chown -h postgres "$LINK"
RESULT=$(su -c "stat -c %U:%G $LINK" postgres)
EXPECTED="postgres:root"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi
FILE_RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
if [ "$FILE_EXPECTED" != "$FILE_RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT on real file"
    ret=1
fi

echo
TEST="chown symlink uid only (root)"
rm -rf "$LINK"
ln -s "$FILE" "$LINK"
chown -h root "$LINK"
RESULT=$(su -c "stat -c %U:%G $LINK" postgres)
EXPECTED="root:root"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi
FILE_RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
if [ "$FILE_EXPECTED" != "$FILE_RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT on real file"
    ret=1
fi

echo
TEST="chown symlink gid only (nobody)"
rm -rf "$LINK"
ln -s "$FILE" "$LINK"
chown -h :nobody "$LINK"
RESULT=$(su -c "stat -c %U:%G $LINK" postgres)
EXPECTED="root:nobody"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi
FILE_RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
if [ "$FILE_EXPECTED" != "$FILE_RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT on real file"
    ret=1
fi

echo
TEST="chown symlink gid only (postgres)"
rm -rf "$LINK"
ln -s "$FILE" "$LINK"
chown -h :postgres "$LINK"
RESULT=$(su -c "stat -c %U:%G $LINK" postgres)
EXPECTED="root:postgres"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi
FILE_RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
if [ "$FILE_EXPECTED" != "$FILE_RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT on real file"
    ret=1
fi

echo
TEST="chown symlink gid only (root)"
rm -rf "$LINK"
ln -s "$FILE" "$LINK"
chown -h :root "$LINK"
RESULT=$(su -c "stat -c %U:%G $LINK" postgres)
EXPECTED="root:root"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi
FILE_RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
if [ "$FILE_EXPECTED" != "$FILE_RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT on real file"
    ret=1
fi

echo
TEST="chown symlink uid and gid (nobody)"
rm -rf "$LINK"
ln -s "$FILE" "$LINK"
chown -h nobody:nobody "$LINK"
RESULT=$(su -c "stat -c %U:%G $LINK" postgres)
EXPECTED="nobody:nobody"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi
FILE_RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
if [ "$FILE_EXPECTED" != "$FILE_RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT on real file"
    ret=1
fi

echo
TEST="chown symlink uid and gid (postgres)"
rm -rf "$LINK"
ln -s "$FILE" "$LINK"
chown -h postgres:postgres "$LINK"
RESULT=$(su -c "stat -c %U:%G $LINK" postgres)
EXPECTED="postgres:postgres"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi
FILE_RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
if [ "$FILE_EXPECTED" != "$FILE_RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT on real file"
    ret=1
fi

echo
TEST="chown symlink uid and gid (root)"
rm -rf "$LINK"
ln -s "$FILE" "$LINK" 
chown -h root:root "$LINK"
RESULT=$(su -c "stat -c %U:%G $LINK" postgres)
EXPECTED="root:root"
if [ "$EXPECTED" != "$RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT"
    ret=1
fi
FILE_RESULT=$(su -c "stat -c %U:%G $FILE" postgres)
if [ "$FILE_EXPECTED" != "$FILE_RESULT" ]; then
    echo "$TEST: expected $EXPECTED got $RESULT on real file"
    ret=1
fi

exit $ret
