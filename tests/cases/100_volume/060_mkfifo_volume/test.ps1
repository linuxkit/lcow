# SUMMARY: Create a fifo on a volume mount and check in container
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$ret = 0

$imageName = "mkfifo-container"
$fileName = "foobar"

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

$p = [string]$pwd.Path
docker run --rm -v  $p`:/test $imageName /mkfifo_test.sh /test/$fileName
if ($lastexitcode -ne 0) { 
    $ret = 1
}

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore
exit $ret
