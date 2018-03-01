# SUMMARY: Pull an image from a different public registry (gcr.io)
# LABELS:
# REPEAT:

docker pull --platform linux gcr.io/google_containers/k8s-dns-sidecar-amd64:1.14.7
if ($lastexitcode -ne 0) { exit 1 }
exit 0
