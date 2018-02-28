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

exit 0
