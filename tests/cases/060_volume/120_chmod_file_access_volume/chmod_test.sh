#!/bin/sh

set -e
set -x

FILE=$1
CONTENT="foo"
CONTENT2="foo2"
ret=0

adduser -D testuser
adduser -D testuser2
adduser testuser daemon

rm -rf "$FILE"
echo "$CONTENT" > "$FILE"
chmod 0600 "$FILE"
chown root:daemon "$FILE"

echo
TEST="file r/w root user only. Read access as root"
RESULT=$(cat "$FILE")
if [ "$CONTENT" != "$RESULT" ]; then
    echo "$TEST: expected $CONTENT got $RESULT"
    ret=1
fi

echo
TEST="file r/w root user only. Write access as root"
echo "$CONTENT2" > "$FILE"
RESULT=$(cat "$FILE")
if [ "$CONTENT2" != "$RESULT" ]; then
    echo "$TEST: expected $CONTENT2 got $RESULT"
    ret=1
fi

echo
TEST="file r/w root user only. Read access as testuser"
set +e
su -c "cat $FILE" testuser
res=$?
set -e
if [ "$res" != "1" ]; then
    echo "$TEST: expected it to fail"
    ret=1
fi

echo
TEST="file r/w root user only. Write access as testuser"
set +e
su -c "echo $CONTENT > $FILE" testuser
res=$?
set -e
if [ "$res" != "1" ]; then
    echo "$TEST: expected it to fail"
    ret=1
fi

echo
TEST="file r/w root user only. Read access as testuser2"
set +e
su -c "cat $FILE" testuser2
res=$?
set -e
if [ "$res" != "1" ]; then
    echo "$TEST: expected it to fail"
    ret=1
fi

echo
TEST="file r/w root user only. Write access as testuser2"
set +e
su -c "echo $CONTENT > $FILE" testuser2
res=$?
set -e
if [ "$res" != "1" ]; then
    echo "$TEST: expected it to fail"
    ret=1
fi

# change to allow group access
rm -rf "$FILE"
echo "$CONTENT" > "$FILE"
chmod 0660 "$FILE"
chown root:daemon "$FILE"

echo
TEST="file r/w user/group only. Read access as testuser"
RESULT=$(su -c "cat $FILE" testuser)
if [ "$CONTENT" != "$RESULT" ]; then
    echo "$TEST: expected $CONTENT got $RESULT"
    ret=1
fi

echo
TEST="file r/w user/group only. Write access as testuser"
su -c "echo $CONTENT2 > $FILE" testuser
RESULT=$(cat "$FILE")
if [ "$CONTENT2" != "$RESULT" ]; then
    echo "$TEST: expected $CONTENT2 got $RESULT"
    ret=1
fi

echo
TEST="file r/w root user only. Read access as testuser2"
set +e
su -c "cat $FILE" testuser2
res=$?
set -e
if [ "$res" != "1" ]; then
    echo "$TEST: expected it to fail"
    ret=1
fi

echo
TEST="file r/w root user only. Write access as testuser2"
set +e
su -c "echo $CONTENT > $FILE" testuser2
res=$?
set -e
if [ "$res" != "1" ]; then
    echo "$TEST: expected it to fail"
    ret=1
fi

exit $ret
