# SUMMARY: Multistage build with a FROM scratch
# LABELS:
# REPEAT:
# ISSUE: https://github.com/Microsoft/opengcs/issues/169
# ISSUE: https://github.com/moby/moby/issues/36115
# ISSUE: https://github.com/moby/moby/issues/35413 (closed)
# ISSUE: https://github.com/Microsoft/opengcs/issues/156 (closed)


$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$imageName = "build-multi-stage-scratch"

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

docker inspect $imageName
if ($lastexitcode -ne 0) {
    $ret = 1
}

docker rmi $imageName
if ($lastexitcode -ne 0) {
    $ret = 1
}
exit $ret
