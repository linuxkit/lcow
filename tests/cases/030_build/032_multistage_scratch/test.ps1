# SUMMARY: Multistage build with a FROM scratch
# LABELS:
# REPEAT:
# See:
# https://github.com/Microsoft/opengcs/issues/169
# https://github.com/moby/moby/issues/35413
# https://github.com/Microsoft/opengcs/issues/156


Set-PSDebug -Trace 2

$imageName = "build-multi-stage-scratch"

docker build -t $imageName .
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
