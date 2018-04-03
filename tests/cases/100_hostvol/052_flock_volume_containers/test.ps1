# SUMMARY: Check that flock() works between containers sharing the same volume
# LABELS:
# REPEAT:
# ISSUE: https://github.com/moby/moby/issues/36531#issuecomment-372020535

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$fileName = "lockfile"
$testPath = Join-Path -Path $env:TEST_TMP -ChildPath $fileName
$containerName = $env:RT_TEST_NAME

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
New-Item -ItemType Directory -Force -Path $env:TEST_TMP

# Check that flock works first
docker container run --platform linux --rm --name $containerName -v $env:TEST_TMP`:/test alpine:3.7 `
  flock -x /test/$fileName echo "flock works"
if ($lastexitcode -ne 0) {
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
    exit 1
}

# Start a container in the background which locks the file
docker container run --platform linux --rm -d --name $containerName -v $env:TEST_TMP`:/test alpine:3.7 `
  flock -x /test/$fileName sleep 1000

# Start another container trying to lock the same file. This should fail
docker container run --platform linux --rm -v $env:TEST_TMP`:/test alpine:3.7 `
  flock -xn /test/$fileName echo "locked although locked"
if ($lastexitcode -eq 0) {
    $ret = 1
}

# remove the background container
docker kill $containerName

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
exit $ret
