# SUMMARY: Try to remove a non-empty sub-directory on a mounted volume
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "rmdir-nonempty"

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

$p = [string]$pwd.Path
docker run --rm -v  $p`:/test $imageName /rmdir_test.sh /test
if ($lastexitcode -ne 0) { 
    exit 1
}
exit 0
