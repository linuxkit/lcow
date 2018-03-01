# SUMMARY: Check that docker image inspect works
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "hello-world"

docker image pull --platform linux $imageName
if ($lastexitcode -ne 0) {
    exit 1
}

$output = [string] (& docker inspect $imageName 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
Write-Output "Output of docker inspect of the image:"
$output | ConvertFrom-Json | ConvertTo-Json

exit 0
