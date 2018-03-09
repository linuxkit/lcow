
# Turn on tracing
Set-PSDebug -Trace 2

# Temporary directories
# TEST_TMP_ROOT: Root for all temporary directories/files
# TEST_TMP:      Per test temporary directory
$env:TEST_TMP_ROOT = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _tmp
$env:TEST_TMP = Join-Path -Path $env:TEST_TMP_ROOT -ChildPath $env:RT_TEST_NAME
