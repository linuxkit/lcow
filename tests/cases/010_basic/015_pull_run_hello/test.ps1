# SUMMARY: Pull hello-world and run it
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

docker rmi hello-world

docker pull --platform linux hello-world
if ($lastexitcode -ne 0) {
    exit 1
}

# If we pulled with --platform we should not need to specify it for run
$output = [string] (& docker run --rm hello-world 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
$output

$tmp = $output | select-string "Hello from Docker!" -SimpleMatch
if ($tmp.length -eq 0) {
    exit 1
}

docker rmi --force hello-world
if ($lastexitcode -ne 0) {
    exit 1
}

exit 0
