# SUMMARY: docker build with build arg
# LABELS:
# REPEAT:
# See:
# https://github.com/Microsoft/opengcs/issues/168

Set-PSDebug -Trace 2

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
    exit 1
}

docker inspect $imageName
if ($lastexitcode -ne 0) {
    exit 1
}

docker rmi $imageName
if ($lastexitcode -ne 0) {
    exit 1
}
exit 0
