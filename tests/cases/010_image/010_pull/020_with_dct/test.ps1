# SUMMARY: Run docker image pull with content trust
# LABELS:
# REPEAT:

$env:DOCKER_CONTENT_TRUST=1
docker image pull --platform linux alpine:3.7
if ($lastexitcode -ne 0) { exit 1 }
exit 0
