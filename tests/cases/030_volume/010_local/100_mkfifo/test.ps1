# SUMMARY: Create a fifo on a local volume
# LABELS:
# REPEAT:
#
# Some systems, like LCOW, may use different filesystems to
# implement local volumes. This test is there to check some
# more "excotic" operations one might do on a shared volume.

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

docker volume create -d local $env:RT_TEST_NAME
if ($lastexitcode -ne 0) {
    exit 1
}

docker container run --platform linux --rm -v $env:RT_TEST_NAME`:/test alpine:3.7 mkfifo /test/foobar
if ($lastexitcode -ne 0) {
    $ret = 1
}

docker volume rm $env:RT_TEST_NAME
if ($lastexitcode -ne 0) {
    $ret = 1
}

exit $ret
