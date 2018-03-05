# SUMMARY: docker build with FROM scratch and COPY a file
# LABELS:
# REPEAT:
# ISSUE: https://github.com/Microsoft/opengcs/issues/156 (closed)

Set-PSDebug -Trace 2

$ret = 0

$imageName = "build-from-scratch-copy"

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
