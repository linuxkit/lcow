# create some test directories here so they are not part of the test

$libBase = Join-Path -Path $env:RT_PROJECT_ROOT -ChildPath _lib
$lib = Join-Path -Path $libBase -ChildPath lib.ps1
. $lib

$res = 0

# these need to be kept in sync with the respective test
$singleDirStat = Join-Path -Path $env:TEST_TMP_ROOT -ChildPath "single-dir-stat"
$singleDirTouch = Join-Path -Path $env:TEST_TMP_ROOT -ChildPath "single-dir-touch"
$singleDirTouchStat = Join-Path -Path $env:TEST_TMP_ROOT -ChildPath "single-dir-touch-stat"
$singleDirRead = Join-Path -Path $env:TEST_TMP_ROOT -ChildPath "single-dir-read"
$singleDirReadRead = Join-Path -Path $env:TEST_TMP_ROOT -ChildPath "single-dir-read-read"

function GroupInit([REF]$res) {
    # Create files for stat testing
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $singleDirStat
    New-Item -ItemType Directory -Force -Path $singleDirStat
    $i = 0
    While ($i -lt 5000) {
        $fileName = "file-stat-" + $i
        $filePath = Join-Path -Path $singleDirStat -ChildPath $fileName
        New-Item -ItemType File -Path $filePath
        $i += 1
    }

    # Create files for touch testing
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $singleDirTouch
    New-Item -ItemType Directory -Force -Path $singleDirTouch
    $i = 0
    While ($i -lt 5000) {
        $fileName = "file-touch-" + $i
        $filePath = Join-Path -Path $singleDirTouch -ChildPath $fileName
        New-Item -ItemType File -Path $filePath
        $i += 1
    }

    # Create files for touch + stat testing
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $singleDirTouchStat
    New-Item -ItemType Directory -Force -Path $singleDirTouchStat
    $i = 0
    While ($i -lt 5000) {
        $fileName = "file-touch-stat-" + $i
        $filePath = Join-Path -Path $singleDirTouchStat -ChildPath $fileName
        New-Item -ItemType File -Path $filePath
        $i += 1
    }

    # Create files for a read test
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $singleDirRead
    New-Item -ItemType Directory -Force -Path $singleDirRead
    $i = 0
    While ($i -lt 5000) {
        $fileName = "file-read-" + $i
        $filePath = Join-Path -Path $singleDirRead -ChildPath $fileName
        $f = new-object System.IO.FileStream $filePath, Create, ReadWrite
        $f.SetLength(512)
        $f.Close()
        $i += 1
    }

    # Create files for a read read test
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $singleDirReadRead
    New-Item -ItemType Directory -Force -Path $singleDirReadRead
    $i = 0
    While ($i -lt 5000) {
        $fileName = "file-read-read-" + $i
        $filePath = Join-Path -Path $singleDirReadRead -ChildPath $fileName
        $f = new-object System.IO.FileStream $filePath, Create, ReadWrite
        $f.SetLength(512)
        $f.Close()
        $i += 1
    }

    $res.Value = 0
}

function GroupDeinit([REF]$res) {
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $singleDirStat
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $singleDirTouch
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $singleDirTouchStat
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $singleDirRead
    Remove-Item -Force -Recurse -ErrorAction Ignore -Path $singleDirReadRead
    $res.Value = 0
}

$CMD=$args[0]
Switch ($CMD) {
    'init'    { GroupInit([REF]$res) }
    'deinit'  { GroupDeinit([REF]$res) }
}

exit $res
