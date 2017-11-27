# SUMMARY: Run docker info
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$output = [string] (& docker info 2>&1)
if ($lastexitcode -ne 0) { 
    $output
    exit 1
}
$output

# Check that we use lcow
$tmp = $output | select-string "lcow (linux)" -SimpleMatch
if ($tmp.length -eq 0) {
    exit 1
}
exit 0