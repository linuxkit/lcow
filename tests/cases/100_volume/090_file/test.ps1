# SUMMARY: Volume mount a single file into container
# LABELS:
# REPEAT:
# ISSUE: https://github.com/moby/moby/issues/35425
# ISSUE: https://github.com/docker/for-win/issues/1360

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$fileName = "foobar"

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore
Get-Date | Set-Content $fileName

$p = [string]$pwd.Path
$p = Join-Path -Path $p -ChildPath $fileName
docker run --platform linux --rm -v  $p`:/test alpine:3.7 sh -c "cat test"
if ($lastexitcode -ne 0) { 
    exit 1
}

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore
exit 0
