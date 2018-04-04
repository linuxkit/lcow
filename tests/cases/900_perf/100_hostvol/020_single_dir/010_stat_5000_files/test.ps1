# SUMMARY: Stat 5000 files in a single directory created on the host
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$testPath = Join-Path -Path $env:TEST_TMP_ROOT -ChildPath "single-dir-stat"

$p = [string]$pwd.Path
docker container run --platform linux --rm `
  -v $testPath`:/test `
  -v $p`:/script `
  alpine:3.7 sh /script/run.sh /test
if ($lastexitcode -ne 0) {
    $ret = 1
}

exit $ret
