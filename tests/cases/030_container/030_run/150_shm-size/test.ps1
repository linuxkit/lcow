# SUMMARY: Verify that docker container run --shm-size works
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$output = [string] (& docker container run --platform linux --rm --shm-size 4096 alpine:3.7 sh -c "mount | grep shm" 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
$output

if (!($output -match "size=4k")) {
    exit 1
}
exit 0
