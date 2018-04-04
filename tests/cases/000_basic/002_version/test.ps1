# SUMMARY: Run docker version
# LABELS:
# REPEAT:

docker version
if ($lastexitcode -ne 0) { exit 1 }
exit 0