# SUMMARY: Check file access time
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$fileName = "foobar"

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore

#
# Create a file in a container and check on the host
#
$p = [string]$pwd.Path
docker run --rm -v  $p`:/test -e TZ=UTC alpine touch -t 197002010000.00 /test/$fileName

# check timestamp
$expected = Get-Date -Date "1970-02-01 00:00:00Z"
$result = [datetime](Get-ItemProperty -Path $fileName -Name LastWriteTime).lastwritetime
if ($expected -ne $result) {
    Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore
    exit 1
}

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore

#
# Create a file on the host and check in a container
#
$ts = Get-Date -Date "1970-01-01 00:00:00Z"
New-Item -ItemType File -Path $fileName
Set-ItemProperty -Path $fileName -Name LastWriteTime -Value $ts
# XXX This relies on the numeric time stamp being 0
docker run --rm -v  $p`:/test -e TZ=UTC alpine sh /test/check_time.sh /test/$fileName
if ($lastexitcode -ne 0) {
    $ret = 1
}
Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore
exit $ret
