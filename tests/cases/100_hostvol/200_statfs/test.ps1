# SUMMARY: Verify that volume mounts implement statfs
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$imageName = $env:RT_TEST_NAME

docker image build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

$p = [string]$pwd.Path
docker container run --rm -v  $p`:/test $imageName /statfs_test.sh /test
if ($lastexitcode -ne 0) { 
    exit 1
}

exit 0
