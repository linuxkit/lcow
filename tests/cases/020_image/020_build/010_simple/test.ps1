# SUMMARY: Simple docker build test
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "build-simple"

docker build --platform linux -t $imageName .
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
