# SUMMARY: Create, inspect and remove a local volume
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

docker volume inspect $env:RT_TEST_NAME
if ($lastexitcode -ne 0) {
    $ret = 1
}

docker volume rm $env:RT_TEST_NAME
if ($lastexitcode -ne 0) {
    $ret = 1
}

exit $ret
