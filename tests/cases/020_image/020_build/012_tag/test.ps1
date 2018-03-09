# SUMMARY: Simple docker build test with tagging
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$imageName = $env:RT_TEST_NAME
$imageTagged = $env:RT_TEST_NAME + ":foobar"

docker build --platform linux -t $imageName .
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
