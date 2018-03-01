# SUMMARY: Test docker image save
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$ret = 0

$fileName = "hello-world.tar"

docker pull --platform linux hello-world
if ($lastexitcode -ne 0) {
    exit 1
}

docker image save -o $fileName hello-world
if ($lastexitcode -ne 0) {
    $ret = 1
}

if (!(Test-Path $fileName)) {
    $ret = 1
}
Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore
exit $ret
