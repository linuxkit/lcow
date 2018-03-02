# SUMMARY: Volume mount a single file into container
# LABELS:
# REPEAT:
# See:
# https://github.com/moby/moby/issues/35425

Set-PSDebug -Trace 2

$fileName = "foobar"

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore
Get-Date | Set-Content $fileName

$p = [string]$pwd.Path
docker run --platform linux --rm `
  -v /var/run/docker.sock:/var/run/docker.sock `
  -v $p`:/test `
  alpine:3.7 sh /test/socket-test.sh
if ($lastexitcode -ne 0) { 
    exit 1
}

Remove-Item -Path $fileName -Force -Recurse -ErrorAction Ignore
exit 0
