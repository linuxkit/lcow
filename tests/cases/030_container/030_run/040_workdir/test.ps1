# SUMMARY: Verify that docker container run --workdir works
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$output = [string] (& docker container run --platform linux --rm --workdir /foobar alpine:3.7 pwd 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
$output

$tmp = $output | select-string "/foobar" -SimpleMatch
if ($tmp.length -eq 0) {
    exit 1
}
exit 0
