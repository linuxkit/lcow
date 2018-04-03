# SUMMARY: Linux Containers on Windows (LCOW) tests
# LABELS:
# NAME: lcow

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$res = 0

function GroupInit([REF]$res) {
    # remove images here rather than in test.ps1
    # so this part is not timed
    docker image rm --force linuxkit/test-lcow:1layer
    docker image rm --force linuxkit/test-lcow:5layers
    docker image rm --force linuxkit/test-lcow:15layers
    docker image rm --force linuxkit/test-lcow:20layers
    docker system prune -f
    
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
