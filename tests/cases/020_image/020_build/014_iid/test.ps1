# SUMMARY: Simple docker build test with iid file
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$ret = 0

$imageName = "build-iid"
$imageIIDFile = "build-iid.file"

Remove-Item -Path $imageIIDFile -Force -Recurse -ErrorAction Ignore

docker build --platform linux -t $imageName --iidfile $imageIIDFile .
if ($lastexitcode -ne 0) {
    exit 1
}

if (!(Test-Path -Path $imageIIDFile)) {
    exit 1
}

$iid = Get-Content $imageIIDFile -Raw 

docker inspect $iid
if ($lastexitcode -ne 0) {
    $ret = 1
}

docker rmi $iid
if ($lastexitcode -ne 0) {
    $ret = 1
}

Remove-Item -Path $imageIIDFile -Force -Recurse -ErrorAction Ignore
exit $ret
