# SUMMARY: Create a sub-directory on a mounted volume and check on the host
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$ret = 0

$baseName = "foobar"
$fileName = "baz"

$dirPath = Join-Path -Path $env:TEST_TMP -ChildPath $baseName
$testPath = Join-Path -Path $dirPath -ChildPath $fileName

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
New-Item -ItemType directory -Force -Path $dirPath

docker container run --platform linux --rm -v  $env:TEST_TMP`:/test alpine:3.7 sh -c "mkdir /test/$baseName/$fileName"
if ($lastexitcode -ne 0) { 
    exit 1
}

if (!(Test-Path $testPath -PathType container)) {
    $ret = 1
}

Remove-Item -Force -Recurse -ErrorAction Ignore -Path $env:TEST_TMP
exit $ret
