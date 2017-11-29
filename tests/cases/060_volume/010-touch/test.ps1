# SUMMARY: Simple test that we can create (touch) a file on the host
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$fileName = "foobar"

# Make sure the 
Remove-Item -Path $fileName -Force

$p = [string]$pwd.Path
docker run --rm -v  $p`:/test alpine:3.6 touch /test/$fileName
if ($lastexitcode -ne 0) { 
    exit 1
}

if (Test-Path $fileName) {
    exit 0
}
exit 1