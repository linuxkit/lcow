# SUMMARY: docker build with FROM defined by build arg
# LABELS:
# REPEAT:
# See:
# https://github.com/Microsoft/opengcs/issues/168

Set-PSDebug -Trace 2

$imageName = "build-from-build-arg"

docker build --platform linux -t $imageName --build-arg IMAGE=alpine:3.6 .
if ($lastexitcode -ne 0) {
    exit 1
}

docker inspect $imageName
if ($lastexitcode -ne 0) {
    exit 1
}

docker rmi $imageName
if ($lastexitcode -ne 0) {
    exit 1
}
exit 0
