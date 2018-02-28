# SUMMARY: Create a file on mounted volume and check contents on the host
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$fileName = "foobar"

if (Test-Path $fileName) {
    Remove-Item -Path $fileName -Force
}

$p = [string]$pwd.Path
docker run --platform linux --rm -v  $p`:/test alpine:3.7 sh -c "echo -n $fileName > /test/$fileName"
if ($lastexitcode -ne 0) { 
    exit 1
}

if (Test-Path $fileName -PathType leaf) {
    $content = Get-Content $fileName -Raw
    Remove-Item -Path $fileName -Force
    if ($content -ne $fileName) {
        $content
        exit 1
    }
    exit 0
}
exit 1
