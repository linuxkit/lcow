# Script to tests.

# Handle kernel/initrd
# If no buildnumber is supplied then it uses the locally build kernel+initrd
if ( Test-Path "$env:ProgramFiles\Linux Containers") {
    Remove-Item "$env:ProgramFiles\Linux Containers" -Force -Recurse
}
if ( $args.Count -eq 1 ) {
    $BuildNumber = $args[0]
    Write-Output "Downloading artefacts for build $BuildNumber"
    Invoke-WebRequest -UseBasicParsing -OutFile release.zip "https://$BuildNumber-111085629-gh.circle-artifacts.com/0/release.zip" 
    Expand-Archive release.zip -DestinationPath "$Env:ProgramFiles\Linux Containers\."
    Remove-Item release.zip
} else {
    if ( !(Test-Path ..\lcow-kernel) -and !(Test-Path ..\bootx64.efi) ) {
        Write-Output "Could not find kernel"
        exit 1
    }
    if ( !(Test-Path ..\lcow-initrd.img) -and !(Test-Path ..\initrd.img) ) {
        Write-Output "Could not find initial ram disk image"
        exit 1
    }
    mkdir "$env:ProgramFiles\Linux Containers"
    if ( Test-Path ..\lcow-kernel ) {
        Copy-Item ..\lcow-kernel "$env:ProgramFiles\Linux Containers\bootx64.efi"
    } else {
        Copy-Item ..\bootx64.efi "$env:ProgramFiles\Linux Containers\bootx64.efi"        
    }
    if ( Test-Path ..\lcow-initrd.img ) {
        Copy-Item ..\lcow-initrd.img "$env:ProgramFiles\Linux Containers\initrd.img"
    } else {
        Copy-Item ..\initrd.img "$env:ProgramFiles\Linux Containers\initrd.img"        
    }
}

if ( !(Test-Path .\bin) ) {
    New-Item -itemtype directory .\bin
}

if ( !(Test-Path .\bin\dockerd.exe) ) {
    Write-Output "Downloading latest docker"
    Invoke-WebRequest -UseBasicParsing -OutFile bin\dockerd.exe https://master.dockerproject.org/windows/x86_64/dockerd.exe
    Invoke-WebRequest -UseBasicParsing -OutFile bin\docker.exe https://master.dockerproject.org/windows/x86_64/docker.exe
}

$rtfBuildNumber = 49
if ( !(Test-Path .\bin\rtf.exe) ) {
    Invoke-WebRequest -UseBasicParsing -OutFile bin\rtf.exe "https://$rtfBuildNumber-89472225-gh.circle-artifacts.com/0/rtf-windows-amd64.exe"
}

$p = [string]$pwd.Path
$env:PATH="$env:PATH;$p\bin"

# Start the docker daemon in the background. Use a separate data-root to have a clean slate
if ( Test-Path C:\lcow-test ) {
     Remove-Item C:\lcow-test -Force -Recurse
}
Start-Process dockerd.exe -ArgumentList '-D', '--experimental', '--data-root', 'C:\lcow-test' `
    -NoNewWindow -RedirectStandardOutput '.\bin\dockerd.out' -RedirectStandardError '.\bin\dockerd.err'

Start-Sleep -Seconds 5

rtf.exe run

Stop-Process -Name dockerd
