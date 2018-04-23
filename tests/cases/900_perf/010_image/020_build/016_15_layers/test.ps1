# SUMMARY: Build an image with fifteen layers
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$imageName = $env:RT_TEST_NAME

$start = Get-Date

docker image build --no-cache --network none --platform linux -t $imageName .
if ($lastexitcode -ne 0) { exit 1 }

$end = Get-Date
$diff = (($end - $start).TotalSeconds).ToString("#.##s")
Write-Output "RT_BENCHMARK_RESULT: $diff"

exit 0
