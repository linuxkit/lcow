# SUMMARY: Check file access time
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$fileName = "foobar"

if (Test-Path $fileName) {
    Remove-Item -Path $fileName -Force
}

#
# Create a file in a container and check on the host
#
$p = [string]$pwd.Path
docker run --rm -v  $p`:/test -e TZ=UTC alpine touch -t 197002010000.00 /test/$fileName

# check timestamp
$expected = Get-Date -Date "1970-02-01 00:00:00Z"
$result = [datetime](Get-ItemProperty -Path $fileName -Name LastWriteTime).lastwritetime
if ($expected -ne $result) {
    exit 1
}

if (Test-Path $fileName) {
    Remove-Item -Path $fileName -Force
}

#
# Create a file on the host and check in a container
#
$ts = Get-Date -Date "1970-01-01 00:00:00Z"
New-Item -ItemType File -Path $fileName
Set-ItemProperty -Path $fileName -Name LastWriteTime -Value $ts
# XXX This relies on the numeric time stamp being 0
docker run --rm -v  $p`:/test -e TZ=UTC alpine sh /test/check_time.sh /test/$fileName
if ($lastexitcode -ne 0) {
    if (Test-Path $fileName) {
        Remove-Item -Path $fileName -Force
    }
    exit 1
}
exit 0
