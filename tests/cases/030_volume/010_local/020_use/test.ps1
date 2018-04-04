# SUMMARY: Create a local volume and use it in a container
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

docker volume create -d local $env:RT_TEST_NAME
if ($lastexitcode -ne 0) {
    exit 1
}

docker container run --platform linux --rm -v $env:RT_TEST_NAME`:/test alpine:3.7 touch /test/foobar
if ($lastexitcode -ne 0) {
    $ret = 1
}

docker volume rm $env:RT_TEST_NAME
if ($lastexitcode -ne 0) {
    $ret = 1
}

exit $ret
