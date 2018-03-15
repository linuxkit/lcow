# SUMMARY: Create a unix domain socket a volume mount and check in container
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$imageName = $env:RT_TEST_NAME
$fileName = "foobar"

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
New-Item -ItemType Directory -Force -Path $env:TEST_TMP

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

docker run --rm -v  $env:TEST_TMP`:/test $imageName /socket_test.sh /test/$fileName

if ($lastexitcode -ne 0) { 
    $ret = 1
}

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
exit $ret
