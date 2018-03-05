# SUMMARY: Verify that docker container run --user works
# LABELS:
# REPEAT:
# ISSUE: https://github.com/moby/moby/issues/36469

Set-PSDebug -Trace 2

$output = [string] (& docker container run --platform linux --rm --user postgres alpine:3.7 id 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
$output

$tmp = $output | select-string "(postgres)" -SimpleMatch
if ($tmp.length -eq 0) {
    exit 1
}
exit 0
