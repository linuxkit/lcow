# SUMMARY: Create directories on a mounted volume and check on the host
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$fileName = "foo/bar"
$fileNameWin = "foo\bar"

if (Test-Path $fileNameWin) {
    Remove-Item -Path $fileNameWin -Force
}

$p = [string]$pwd.Path
docker run --platform linux --rm -v  $p`:/test alpine:3.7 sh -c "mkdir -p /test/$fileName"
if ($lastexitcode -ne 0) { 
    exit 1
}

if (Test-Path $fileNameWin -PathType container) {
    Remove-Item -Path $fileNameWin -Force
    exit 0
}
exit 1
