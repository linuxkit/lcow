# LinuxKit based LCOW images

This repository hosts the components to build a LinuxKit based Linux
image for Linux Containers on Windows.

**Note:** LCOW support is currently **experimental** and under active
development. 


## Use

This section describes how to use Linux Containers on Windows with LinuxKit.


### Prerequisites

To use Linux Containers on Windows you need a Windows build supporting
the feature, i.e., Windows 10 Pro or Windows Server 2016 1709 (or
newer Insider builds). You also need to have `Hyper-V` and the
`Container` feature enabled.


### Setup

For now, you need a recent version of `docker`, such as a nightly
build from the master branch. In PowerShell:

```
Invoke-WebRequest -UseBasicParsing -OutFile dockerd.exe https://master.dockerproject.org/windows/x86_64/dockerd.exe
Invoke-WebRequest -UseBasicParsing -OutFile docker.exe https://master.dockerproject.org/windows/x86_64/docker.exe
```

Next, you need to get the LinuxKit images. You can either build them
yourself (see below) or download the latest zip file from the
[releases page](https://github.com/linuxkit/lcow/releases). Then unzip
in an elevated PowerShell:

```
Remove-Item "$env:ProgramFiles\Linux Containers" -Force -Recurse
Expand-Archive release.zip -DestinationPath "$Env:ProgramFiles\Linux Containers\."
rm release.zip
```

### Run

Start the docker daemon (in an elevated PowerShell):

```
$env:LCOW_SUPPORTED=1
$env:LCOW_API_PLATFORM_IF_OMITTED="linux"
Remove-Item c:\lcow -Force -Recurse; mkdir c:\lcow
.\dockerd.exe -D --experimental --data-root c:\lcow
```

You should now be able to run Linux containers on Windows, e.g.:

```
docker run --rm -ti busybox sh
```

If you already have `docker` installed on your system you probably want to start the daemon (and the client) on a non-standard named pipe using the `-H "npipe:////./pipe//docker_lcow"` for both.


## Build

The LinuxKit image is build from [`lcow.yml`](./lcow.yml) and the main
package is called [`init-lcow`](./pkg/init-lcow).

### Prerequisites

To build images you will need the [Moby
tool](https://github.com/moby/tool), and to rebuild the individual
packages you will need the [LinuxKit
tool](https://github.com/linuxkit/linuxkit/tree/master/src/cmd/linuxkit). You
also need to have a working Docker installation.

If you already have `go` installed you can use `go get -u
github.com/moby/tool/cmd/moby` to install the `moby` build tool, and
`go get -u github.com/linuxkit/linuxkit/src/cmd/linuxkit` to install
the `linuxkit` tool.

On macOS there is a `brew tap` available. Detailed instructions are at
[linuxkit/homebrew-linuxkit](https://github.com/linuxkit/homebrew-linuxkit),
the short summary is

```
brew tap linuxkit/linuxkit
brew install --HEAD moby
brew install --HEAD linuxkit
```


### Building the LCOW image

Simply type:

```
make
```

which generates `bootx64.efi` and `initrd.img` which need to be copied to `"$env:ProgramFiles\Linux Containers\bootx64.efi"` on your Windows system.


Alternatively, use:

```
moby build lcow.yml
```

This will generate three files: `lcow-kernel`, `lcow-initrd.img`, and
`lcow-cmdline`. `lcow-kernel` needs to be copied to
`"$env:ProgramFiles\Linux Containers\bootx64.efi"` and
`lcow-initrd.img` to `"$env:ProgramFiles\Linux
Containers\initrd.img"`.


### Building the `init-lcow` package

The [`init-lcow`](./pkg/init-lcow) contains a minimal `init` system
used inside the LCOW and mainly consists of the [OpenGCS
deamon](https://github.com/Microsoft/opengcs). To rebuild the package
use the `linuxkit` tool:

```
linuxkit pkg build -org foo pkg/init-lcow
```

This should create a local image `foo/init-lcow:<tag>` which can be used `lcow.yml`. To build and push the image to hub use:

```
linuxkit pkg build -org <your hub name> -disable-content-trust pkg/init-lcow
```

You can omit `-disable-content-trust` if your registry has Docker
Content Trust enabled.
