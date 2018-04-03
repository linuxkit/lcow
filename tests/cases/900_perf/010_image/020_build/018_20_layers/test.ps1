# SUMMARY: Build an image with twenty layers
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$imageName = $env:RT_TEST_NAME

docker image build --no-cache --network none --platform linux -t $imageName .
if ($lastexitcode -ne 0) { exit 1 }
exit 0
