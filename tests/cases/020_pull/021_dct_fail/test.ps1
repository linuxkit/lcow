# SUMMARY: Run docker pull unsigned image with content trust
# LABELS:
# REPEAT:

$env:DOCKER_CONTENT_TRUST=1
docker pull prom/node-exporter
if ($lastexitcode -eq 0) { exit 1 }
exit 0