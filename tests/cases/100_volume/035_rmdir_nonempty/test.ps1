# SUMMARY: Try to remove a non-empty sub-directory on a mounted volume
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$imageName = "rmdir-nonempty"
$fileName = "output"

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

$p = [string]$pwd.Path
docker run --rm -v  $p`:/test $imageName /rmdir_test.sh /test
if ($lastexitcode -ne 0) { 
    $ret = 1
}

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore
exit $ret
