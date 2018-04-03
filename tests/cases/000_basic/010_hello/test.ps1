# SUMMARY: Run docker container run hello-world
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$output = [string] (& docker container run --platform linux --rm hello-world 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
$output

# Check that we use lcow
$tmp = $output | select-string "Hello from Docker!" -SimpleMatch
if ($tmp.length -eq 0) {
    exit 1
}

docker rmi --force hello-world
if ($lastexitcode -ne 0) {
    exit 1
}

exit 0
