# SUMMARY: Try to remove a non-empty sub-directory on a mounted volume
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "rmdir-nonempty"
$fileName = "output"

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

$p = [string]$pwd.Path
docker run --rm -v  $p`:/test $imageName /rmdir_test.sh /test
if ($lastexitcode -ne 0) { 
    if (Test-Path $fileName) {
        Remove-Item -Path $fileName -Force
    }
    exit 1
}
if (Test-Path $fileName) {
    Remove-Item -Path $fileName -Force
}
exit 0
