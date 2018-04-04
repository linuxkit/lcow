# SUMMARY: Create a local volume and share it between two containers
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$containerName = $env:RT_TEST_NAME
$ret = 0

docker volume create -d local $env:RT_TEST_NAME
if ($lastexitcode -ne 0) {
    exit 1
}

# Start a container in the background which creates a file on a local volume
docker container run --platform linux --rm -d --name $containerName `
  -v $env:RT_TEST_NAME`:/test alpine:3.7 sh -c "touch /test/foobar; sleep 1000"

# Start a second container which checks for the file
$p = [string]$pwd.Path
docker container run --platform linux --rm `
  -v $env:RT_TEST_NAME`:/test `
  -v $p`:/script `
  alpine:3.7 sh /script/run.sh /test/foobar
if ($lastexitcode -ne 0) {
    $ret = 1
}

# remove the background container
docker container kill $containerName

docker volume rm $env:RT_TEST_NAME
if ($lastexitcode -ne 0) {
    $ret = 1
}

exit $ret
