# SUMMARY: Run docker run hello-world
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$output = [string] (& docker run --rm hello-world 2>&1)
if ($lastexitcode -ne 0) {
    $output
    exit 1
}
$output

# Check that we use lcow
$tmp = $output | select-string "Hello from Docker!" -SimpleMatch
if ($tmp.length -eq 0) {
    exit 1
}
exit 0