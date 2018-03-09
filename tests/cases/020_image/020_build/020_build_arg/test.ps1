# SUMMARY: docker build with build arg
# LABELS:
# REPEAT:
# ISSUE: https://github.com/Microsoft/opengcs/issues/168 (closed)

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$imageName = "build-arg"

$output = [string] (& docker build --platform linux -t $imageName --build-arg ARGUMENT=foobar . 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
$output

# Check that it echoed the right thing
$tmp = $output | select-string "foobar" -SimpleMatch
if ($tmp.length -eq 0) {
    $ret = 1
}

docker inspect $imageName
if ($lastexitcode -ne 0) {
    $ret = 1
}

docker rmi $imageName
if ($lastexitcode -ne 0) {
    $ret = 1
}
exit $ret
