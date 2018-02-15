# SUMMARY: Check that build failures are propagated
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "build-fail"

docker build --platform linux -t $imageName .
if ($lastexitcode -eq 0) {
    exit 1
}
exit 0
