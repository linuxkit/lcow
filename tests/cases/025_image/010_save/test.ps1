# SUMMARY: Test docker image save
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$fileName = "hello-world.tar"

docker pull --platform linux hello-world
if ($lastexitcode -ne 0) {
    exit 1
}

docker image save -o $fileName hello-world
if ($lastexitcode -ne 0) {
    exit 1
}

if (Test-Path $fileName) {
    Remove-Item -Path $fileName -Force
    exit 0
}
exit 1
