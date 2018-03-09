# SUMMARY: Linux Containers on Windows (LCOW) tests
# LABELS:
# NAME: lcow

Set-PSDebug -Trace 2

$res = 0

function GroupInit([REF]$res) {
    Write-Output "Environment"
    Get-ChildItem Env:
    $res.Value = 0
}

function GroupDeinit([REF]$res) {
    $res.Value = 0
}

$CMD=$args[0]
Switch ($CMD) {
    'init'    { GroupInit([REF]$res) }
    'deinit'  { GroupDeinit([REF]$res) }
}

exit $res
