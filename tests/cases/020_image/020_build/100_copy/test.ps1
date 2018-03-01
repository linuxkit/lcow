# SUMMARY: Test COPY variations
# LABELS:
# REPEAT:
# See:
# https://github.com/moby/moby/issues/36353

Set-PSDebug -Trace 2

$ret = 0

$imageName = "build-copy"
$testDir1 = "folder1"
$testDir2 = "folder2"
$testDir3 = "folder3"

Remove-Item -Path $testDir1 -Force -Recurse -ErrorAction Ignore
Remove-Item -Path $testDir2 -Force -Recurse -ErrorAction Ignore
New-Item -ItemType Directory -Force -Path $testDir1
New-Item -ItemType Directory -Force -Path $testDir2\$testDir3
Copy-Item Dockerfile $testDir1
Copy-Item test.ps1 $testDir2\$testDir3\
Copy-Item Dockerfile $testDir2\$testDir3\
# After this we should have
# - Dockerfile
# - test.ps1
# - folder1
#   - Dockerfile
# - folder2
#   - folder3
#     - test.ps1
#     - Dockerfile

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    $ret = 1
}
docker rmi $imageName
if ($lastexitcode -ne 0) {
    $ret = 1
}

Remove-Item -Path $testDir1 -Force -Recurse -ErrorAction Ignore
Remove-Item -Path $testDir2 -Force -Recurse -ErrorAction Ignore
exit $ret
