# SUMMARY: Verify that volume mounts implement statfs
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "statfs-container"

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

$p = [string]$pwd.Path
docker run --rm -v  $p`:/test $imageName /statfs_test.sh /test
if ($lastexitcode -ne 0) { 
    exit 1
}

exit 0
