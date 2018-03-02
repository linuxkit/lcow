# SUMMARY: Verify that docker container run --env works
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$output = [string] (& docker container run --platform linux --rm --env FOOBAR=foobar alpine:3.7 env 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
$output

$tmp = $output | select-string "FOOBAR=foobar" -SimpleMatch
if ($tmp.length -eq 0) {
    exit 1
}
exit 0
