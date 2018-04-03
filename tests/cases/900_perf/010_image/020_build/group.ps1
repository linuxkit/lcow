# SUMMARY: Linux Containers on Windows (LCOW) tests
# LABELS:
# NAME: lcow

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$res = 0

function GroupInit([REF]$res) {
    # make sure alpine is pulled
    docker image pull --platform linux alpine:3.7
    
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
