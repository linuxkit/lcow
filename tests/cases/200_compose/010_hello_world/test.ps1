# SUMMARY: Run a docker-compose based hello-world
# LABELS: skip
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

docker-compose pull
if ($lastexitcode -ne 0) {
    exit 1
}

$output = [string] (& docker-compose up 2>&1)
if ($lastexitcode -ne 0) {
    $output
    $ret = 1
}
$output

$tmp = $output | select-string "Hello from Docker!" -SimpleMatch
if ($tmp.length -eq 0) {
    $ret = 1
}

docker-compose stop
if ($lastexitcode -ne 0) {
    $ret = 1
}

docker-compose down --rmi all
if ($lastexitcode -ne 0) {
    $ret = 1
}

exit $ret
