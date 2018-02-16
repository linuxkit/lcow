# SUMMARY: Simple docker build test with iid file
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "build-iid"
$imageIIDFile = "build-iid.file"

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
    exit 1
}

docker rmi $iid
if ($lastexitcode -ne 0) {
    exit 1
}
Remove-Item -Path $imageIIDFile -Force
exit 0
