# SUMMARY: Run uname -a in busybox
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$output = [string] (& docker container run --platform linux --rm busybox uname -a 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
$output

# Check that we use lcow
$tmp = $output | select-string "Linux" -SimpleMatch
if ($tmp.length -eq 0) {
    exit 1
}
exit 0
