# SUMMARY: Volume mount a single file into container
# LABELS:
# REPEAT:
# ISSUE: https://github.com/moby/moby/issues/35425
# ISSUE: https://github.com/docker/for-win/issues/1360

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$fileName = "foobar"
$testPath = Join-Path -Path $env:TEST_TMP -ChildPath $fileName

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
New-Item -ItemType Directory -Force -Path $env:TEST_TMP

Get-Date | Set-Content $testPath

docker container run --platform linux --rm -v  $testPath`:/test alpine:3.7 sh -c "cat test"
if ($lastexitcode -ne 0) { 
    exit 1
}

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
exit 0
