# SUMMARY: Pull an image with twenty layers
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$imageName = "linuxkit/test-lcow:20layers"

docker image pull --platform linux $imageName
if ($lastexitcode -ne 0) { exit 1 }
exit 0
