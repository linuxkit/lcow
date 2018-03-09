# SUMMARY: Create a sub-directory on a mounted volume and check on the host
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$baseName = "foobar"
$fileName = "baz"

Remove-Item -Path $baseName -Force -Recurse -ErrorAction Ignore
New-Item -ItemType directory $baseName

$p = [string]$pwd.Path
docker run --platform linux --rm -v  $p`:/test alpine:3.7 sh -c "mkdir /test/$baseName/$fileName"
if ($lastexitcode -ne 0) { 
    exit 1
}

if (!(Test-Path $baseName\$fileName -PathType container)) {
    $ret = 1
}

Remove-Item -Path $baseName -Force -Recurse -ErrorAction Ignore
exit $ret
