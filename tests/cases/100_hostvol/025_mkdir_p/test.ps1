# SUMMARY: Create directories on a mounted volume and check on the host
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 1

$dirName = "foo/bar"

$tmp = Join-Path -Path $env:TEST_TMP -ChildPath foo
$testPath = Join-Path -Path $tmp -ChildPath bar

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
New-Item -ItemType Directory -Force -Path $env:TEST_TMP

docker run --platform linux --rm -v  $env:TEST_TMP`:/test alpine:3.7 sh -c "mkdir -p /test/$dirName"
if ($lastexitcode -ne 0) { 
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP    
    exit 1
}

if (Test-Path $testPath -PathType container) {
    $ret = 0
}

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP    
exit $ret
