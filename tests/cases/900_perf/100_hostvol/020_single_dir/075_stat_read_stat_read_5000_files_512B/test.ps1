# SUMMARY: Stat, read, stat, read 5000 files in a single directory created on the host
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$testPath = $env:TEST_TMP
Remove-Item -Force -Recurse -ErrorAction Ignore -Path $testPath
New-Item -ItemType Directory -Force -Path $testPath
$i = 0
While ($i -lt 5000) {
    $fileName = "test-" + $i
    $filePath = Join-Path -Path $testPath -ChildPath $fileName
    $f = new-object System.IO.FileStream $filePath, Create, ReadWrite
    $f.SetLength(512)
    $f.Close()
    $i += 1
}

$start = Get-Date

$p = [string]$pwd.Path
docker container run --platform linux --rm `
  -v $testPath`:/test `
  -v $p`:/script `
  alpine:3.7 sh /script/run.sh /test
if ($lastexitcode -ne 0) { $ret = 1 }

$end = Get-Date
$diff = (($end - $start).TotalSeconds).ToString("#.##s")
Write-Output "RT_BENCHMARK_RESULT: $diff"

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $testPath

exit $ret
