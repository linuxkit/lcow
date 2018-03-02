# SUMMARY: Simple test with localhost networking
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$ret = 0

$containerID = (& docker run --platform linux -d --rm -p 8080:80 nginx)
if ($lastexitcode -ne 0) { 
    exit 1
}
$containerID

for ($count = 1; $count -le 10; $count++) {
    try {
        $output = Invoke-WebRequest -UseBasicParsing http://localhost:8080    
    } catch {
        Start-Sleep -Seconds 1
        continue
    }
    break
}
Write-Output "Output from request:"
$output

# check if we got the nginx
$tmp = $output | select-string "Welcome to nginx!" -SimpleMatch
if ($tmp.length -eq 0) {
    $ret = 1
}

docker kill $containerID
exit $ret
