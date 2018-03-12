# SUMMARY: Create a file with unicode characters on the host and check in a container
# LABELS:
# REPEAT:
# ISSUE: https://github.com/docker/for-win/issues/986

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

# based on: http://www.columbia.edu/~fdc/utf8/
$fileName = "test-我能吞下.txt"
$testPath = Join-Path -Path $env:TEST_TMP -ChildPath $fileName

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
New-Item -ItemType Directory -Force -Path $env:TEST_TMP

New-Item -ItemType File -Path $testPath

docker run --platform linux --rm -v  $env:TEST_TMP`:/test alpine:3.7 sh -c "test -f /test/$fileName"
if ($lastexitcode -ne 0) { 
    $ret = 1
}

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
exit $ret
