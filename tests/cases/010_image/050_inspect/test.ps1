# SUMMARY: Check that docker image inspect works
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

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
