# SUMMARY: Verify that docker container run --privileged works
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$output = [string] (& docker container run --platform linux --rm --privileged alpine:3.7 id 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
$output
exit 0
