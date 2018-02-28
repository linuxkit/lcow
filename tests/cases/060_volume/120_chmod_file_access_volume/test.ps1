# SUMMARY: Check file access a volume mount in a container
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "chmod-access-container"
$fileName = "foobar"

if (Test-Path $fileName) {
    Remove-Item -Path $fileName -Force
}

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) { 
    exit 1
}

$p = [string]$pwd.Path
docker run --rm -v  $p`:/test $imageName /chmod_test.sh /test/$fileName
if ($lastexitcode -ne 0) { 
    if (Test-Path $fileName) {
        Remove-Item -Path $fileName -Force
    }
    exit 1
}

Remove-Item -Path $fileName -Force
exit 0
