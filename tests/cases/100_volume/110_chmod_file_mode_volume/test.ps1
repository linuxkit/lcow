# SUMMARY: Check changes to a file mode (chmod) on a volume mount in a container
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$ret = 0

$imageName = "chmod-container"
$fileName = "foobar"

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) { 
    exit 1
}

$p = [string]$pwd.Path
docker run --rm -v  $p`:/test $imageName /chmod_test.sh /test/$fileName
if ($lastexitcode -ne 0) { 
    $ret = 1
}

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore
exit $ret
