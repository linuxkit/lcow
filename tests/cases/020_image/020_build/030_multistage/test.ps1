# SUMMARY: Multistage build
# LABELS:
# REPEAT:
# See:
# https://github.com/Microsoft/opengcs/issues/169

Set-PSDebug -Trace 2

$ret = 0

$imageName = "build-multi-stage"

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
