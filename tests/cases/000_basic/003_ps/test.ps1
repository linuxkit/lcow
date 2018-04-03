# SUMMARY: Run docker ps
# LABELS:
# REPEAT:

docker ps
if ($lastexitcode -ne 0) { exit 1 }
exit 0