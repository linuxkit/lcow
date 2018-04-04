# SUMMARY: Verify that WORKDIR in a Dockerfile works
# LABELS:
# REPEAT:
# ISSUE: https://github.com/Microsoft/opengcs/issues/188
# ISSUE: https://github.com/moby/moby/issues/36138

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$imageName = $env:RT_TEST_NAME
docker image build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

$output = [string] (& docker container run --platform linux --rm $imageName pwd 2>&1)
if ($lastexitcode -ne 0) {
    $output
    $ret = 1
}
$output

$tmp = $output | select-string "/foobar" -SimpleMatch
if ($tmp.length -eq 0) {
    $ret = 1
}

docker image rm $imageName
if ($lastexitcode -ne 0) {
    $ret = 1
}

exit $ret
