# SUMMARY: Try to create a file on a read-only volume mount
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
New-Item -ItemType Directory -Force -Path $env:TEST_TMP

docker container run --platform linux --rm -v $env:TEST_TMP`:/test:ro alpine:3.7 touch /test/foobar
if ($lastexitcode -eq 0) { 
    exit 1
}

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
exit $ret
