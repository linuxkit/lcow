# SUMMARY: Pull an image with twenty layers
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$imageName = "linuxkit/test-lcow:20layers"

docker rmi $imageName

$start = Get-Date

docker image pull --platform linux $imageName
if ($lastexitcode -ne 0) { exit 1 }

$end = Get-Date
$diff = (($end - $start).TotalSeconds).ToString("#.##s")
Write-Output "RT_BENCHMARK_RESULT: $diff"

exit 0
