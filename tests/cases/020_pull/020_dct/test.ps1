# SUMMARY: Run docker pull with content trust
# LABELS:
# REPEAT:

$env:DOCKER_CONTENT_TRUST=1
docker pull --platform linux alpine:3.6
if ($lastexitcode -ne 0) { exit 1 }
exit 0
