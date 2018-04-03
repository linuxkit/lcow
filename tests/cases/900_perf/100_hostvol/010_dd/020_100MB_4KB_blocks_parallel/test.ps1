# SUMMARY: Create a 5 100MB files in parallel on shared volume with 4KB writes
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$fileName = "foobar"
$testPath = Join-Path -Path $env:TEST_TMP -ChildPath $fileName

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
New-Item -ItemType Directory -Force -Path $env:TEST_TMP

$blockSize = 4096
$dataSize = 100 * 1024 * 1024
$count = $dataSize / $blockSize

$p = [string]$pwd.Path
docker run --platform linux --rm `
  -v $env:TEST_TMP`:/test `
  -v $p`:/script `
  alpine:3.7 sh /script/dd_5_parallel.sh /test $blockSize $count
if ($lastexitcode -ne 0) { 
    exit 1
}

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
exit $ret
