# SUMMARY: Check that flock() works on a shared volume
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$fileName = "lockfile"
$testPath = Join-Path -Path $env:TEST_TMP -ChildPath $fileName

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
New-Item -ItemType Directory -Force -Path $env:TEST_TMP

$p = [string]$pwd.Path
docker run --platform linux --rm `
  -v $env:TEST_TMP`:/test `
  -v $p`:/script `
  -e TZ=UTC alpine:3.7 sh /script/check_flock.sh /test/$fileName
if ($lastexitcode -ne 0) {
    $ret = 1
}

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
exit $ret
