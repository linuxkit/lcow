# SUMMARY: Verify docker run --read-only works
# LABELS:
# REPEAT:

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

docker container run --platform linux --rm --read-only alpine:3.7 touch /foobar
if ($lastexitcode -eq 0) {
    exit 1
}
exit 0
