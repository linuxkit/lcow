# SUMMARY: Verify that docker container run --user works
# LABELS:
# REPEAT:
# ISSUE: https://github.com/moby/moby/issues/36469

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

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
