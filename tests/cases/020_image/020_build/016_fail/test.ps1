# SUMMARY: Check that build failures are propagated
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$imageName = "build-fail"

docker build --platform linux -t $imageName .
if ($lastexitcode -eq 0) {
    exit 1
}
exit 0
