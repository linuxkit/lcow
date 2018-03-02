# SUMMARY: Verify docker run --read-only works
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

docker container run --platform linux --rm --read-only alpine:3.7 touch /foobar
if ($lastexitcode -eq 0) {
    exit 1
}
exit 0
