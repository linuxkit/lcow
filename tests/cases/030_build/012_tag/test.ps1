# SUMMARY: Simple docker build test with tagging
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "build-tag"
$imageTagged = "build-tag:foobar"

docker build -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

docker tag $imageName $imageTagged
if ($lastexitcode -ne 0) {
    exit 1
}

docker inspect $imageTagged
if ($lastexitcode -ne 0) {
    exit 1
}

docker rmi $imageTagged
if ($lastexitcode -ne 0) {
    exit 1
}
exit 0
