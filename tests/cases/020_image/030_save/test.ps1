# SUMMARY: Test docker image save
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$fileName = "hello-world.tar"

docker pull --platform linux hello-world
if ($lastexitcode -ne 0) {
    exit 1
}

docker image save -o $fileName hello-world
if ($lastexitcode -ne 0) {
    $ret = 1
}

if (!(Test-Path $fileName)) {
    $ret = 1
}
Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore
exit $ret
