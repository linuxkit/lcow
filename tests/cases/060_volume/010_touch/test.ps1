# SUMMARY: Create (touch) a file on volume mount and check on the host
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$fileName = "foobar"

if (Test-Path $fileName) {
    Remove-Item -Path $fileName -Force
}

$p = [string]$pwd.Path
docker run --platform linux --rm -v  $p`:/test alpine:3.7 sh -c "touch /test/$fileName"
if ($lastexitcode -ne 0) { 
    exit 1
}

if (Test-Path $fileName -PathType leaf) {
    Remove-Item -Path $fileName -Force
    exit 0
}
exit 1
