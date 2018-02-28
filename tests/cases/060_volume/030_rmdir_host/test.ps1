# SUMMARY: Remove a subdir create on the host in a container
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$dirName = "foobar"

if (Test-Path $dirName) {
    Remove-Item -Path $dirName -Force -Recurse
}

New-Item -ItemType directory $dirName

$p = [string]$pwd.Path
docker run --platform linux --rm -v  $p`:/test alpine:3.7 sh -c "rmdir /test/$dirName"
if ($lastexitcode -ne 0) { 
    exit 1
}

if (Test-Path $dirName) {
    Remove-Item -Path $baseName -Force -Recurse
    exit 1
}
exit 0
