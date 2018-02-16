# SUMMARY: Test docker image save
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$fileName = "hello-world.tar"
$imageName = "hello-world:latest"

docker image rm hello-world

docker image load -i $fileName
if ($lastexitcode -ne 0) {
    exit 1
}

$output = [string] (& docker image inspect $imageName 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
Write-Output "Output of docker inspect of the image:"
$output | ConvertFrom-Json | ConvertTo-Json

# Now try to run it
docker run --rm $imageName
if ($lastexitcode -ne 0) {
    exit 1
}

exit 0
