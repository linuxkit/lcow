# SUMMARY: Create a fifo on a volume mount and check in container
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "mkfifo-container"
$fileName = "foobar"

if (Test-Path $fileName) {
    Remove-Item -Path $fileName -Force
}

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

$p = [string]$pwd.Path
docker run --rm -v  $p`:/test $imageName /mkfifo_test.sh /test/$fileName
if ($lastexitcode -ne 0) { 
    if (Test-Path $fileName) {
        Remove-Item -Path $fileName -Force
    }
    exit 1
}

Remove-Item -Path $fileName -Force
exit 0
