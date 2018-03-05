# SUMMARY: docker build with a WORKDIR set
# LABELS:
# REPEAT:
# ISSUE: https://github.com/docker/for-win/issues/1358 (closed)

Set-PSDebug -Trace 2

$ret = 0

$imageName = "build-workdir"

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
