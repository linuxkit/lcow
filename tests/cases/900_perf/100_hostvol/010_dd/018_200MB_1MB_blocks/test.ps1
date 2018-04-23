# SUMMARY: Create a 200MB file on shared volume with 1MB writes
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

$blockSize = 1024 * 1024
$dataSizeMB = 200
$dataSize = $dataSizeMB * 1024 * 1024
$count = $dataSize / $blockSize

$start = Get-Date

docker container run --platform linux --rm -v  $env:TEST_TMP`:/test alpine:3.7 `
  sh -c "dd if=/dev/zero of=/test/$fileName bs=$blockSize count=$count"
if ($lastexitcode -ne 0) { exit 1 }

$end = Get-Date
$diff = ($end - $start).TotalSeconds
$res = ($dataSizeMB / $diff).ToString("#.## MB/s")
Write-Output "RT_BENCHMARK_RESULT: $res"

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
exit $ret
