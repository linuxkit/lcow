# SUMMARY: Check file access time
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

#
# Create a file in a container and check on the host
#
docker run --rm -v  $env:TEST_TMP`:/test -e TZ=UTC alpine:3.7 touch -t 197002010000.00 /test/$fileName

# check timestamp
$expected = Get-Date -Date "1970-02-01 00:00:00Z"
$result = [datetime](Get-ItemProperty -Path $testPath -Name LastWriteTime).lastwritetime
if ($expected -ne $result) {
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
    exit 1
}

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
New-Item -ItemType Directory -Force -Path $env:TEST_TMP

#
# Create a file on the host and check in a container
#
$ts = Get-Date -Date "1970-01-01 00:00:00Z"
New-Item -ItemType File -Path $testPath
Set-ItemProperty -Path $testPath -Name LastWriteTime -Value $ts
# XXX This relies on the numeric time stamp being 0
$p = [string]$pwd.Path
docker run --platform linux --rm `
  -v $env:TEST_TMP`:/test `
  -v $p`:/script `
  -e TZ=UTC alpine:3.7 sh /script/check_time.sh /test/$fileName
if ($lastexitcode -ne 0) {
    $ret = 1
}

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
exit $ret
