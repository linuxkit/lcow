# SUMMARY: Create a symlink on a volume mount and check in container
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "symlink-container"
$fileName = "foobar"
$linkName = "barfoo"

if (Test-Path $fileName) {
    Remove-Item -Path $fileName -Force
}
if (Test-Path $linkName) {
    Remove-Item -Path $linkName -Force
}

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

$p = [string]$pwd.Path
docker run --rm -v  $p`:/test $imageName /symlink_test.sh /test/$fileName /test/$linkName
if ($lastexitcode -ne 0) { 
    if (Test-Path $fileName) {
        Remove-Item -Path $fileName -Force
    }
    if (Test-Path $linkName) {
        Remove-Item -Path $linkName -Force
    }
    exit 1
}

Remove-Item -Path $fileName -Force
Remove-Item -Path $linkName -Force
exit 0
