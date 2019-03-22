# LinuxKit based LCOW images

[![CircleCI](https://circleci.com/gh/linuxkit/lcow.svg?style=svg)](https://circleci.com/gh/linuxkit/lcow)

This repository hosts the components to build a LinuxKit based Linux
image for Linux Containers on Windows.

**Note:** LCOW support is currently **experimental** and under active
development. 

**Note:** Issues are currently disabled on this project. For LinuxKit specific issues, please file an issue under [linuxkit/linuxkit](https://github.com/linuxkit/linuxkit). For general LCOW issues, consider opening an issue under [moby/moby](https://github.com/moby/moby)


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

On recent `docker` master builds (`master-dockerproject-2018-01-20, build 44a1168a` or newer):

Start the docker daemon (in an elevated PowerShell):

```
.\dockerd.exe -D --experimental
```

You should now be able to run Linux containers on Windows, e.g.:

```
docker run --platform linux --rm -ti busybox sh
```

On older `docker` master builds:

Start the docker daemon (in an elevated PowerShell):

```
$env:LCOW_SUPPORTED=1
$env:LCOW_API_PLATFORM_IF_OMITTED="linux"
Remove-Item c:\lcow -Force -Recurse; mkdir c:\lcow
.\dockerd.exe -D --experimental --data-root c:\lcow
```

(Note: If your kernel is older than 4.14 and is configured with KASLR
you may want to add `--storage-opt lcow.bootparameters="nokaslr"` to
the `dockerd` command line.)

You should now be able to run Linux containers on Windows, e.g.:

```
docker run --rm -ti busybox sh
```

If you already have `docker` installed on your system you probably
want to start the daemon (and the client) on a non-standard named pipe
using the `-H "npipe:////./pipe//docker_lcow"` for both.


## Build

The LinuxKit image is build from [`lcow.yml`](./lcow.yml) and the main
package is called [`init-lcow`](./pkg/init-lcow).

### Prerequisites

To build images and packages you will need the [LinuxKit
tool](https://github.com/linuxkit/linuxkit/tree/master/src/cmd/linuxkit). You
also need to have a working Docker installation.

If you already have `go` installed you can use `go get -u
github.com/linuxkit/linuxkit/src/cmd/linuxkit` to install the
`linuxkit` tool.

On macOS there is a `brew tap` available. Detailed instructions are at
[linuxkit/homebrew-linuxkit](https://github.com/linuxkit/homebrew-linuxkit),
but the short summary is:

```
brew tap linuxkit/linuxkit
brew install --HEAD linuxkit
```


### Building the LCOW image

Simply type:

```
make
```

which generates `kernel` and `initrd.img` which need to be copied to `"$env:ProgramFiles\Linux Containers\kernel"` on your Windows system.


Alternatively, use:

```
linuxkit build lcow.yml
```

This will generate three files: `lcow-kernel`, `lcow-initrd.img`, and
`lcow-cmdline`. `lcow-kernel` needs to be copied to
`"$env:ProgramFiles\Linux Containers\kernel"` and
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


## Test

The [`tests`](./tests) directory contains a number of tests for LCOW
written using [`rtf`](https://github.com/linuxkit/rtf). To run them
you can simply execute [`RunTests.ps1`](./tests/RunTests.ps1) inside
the `.\tests` directory. It will pick up the kernel/initrd in the
parent directory if present. Alternatively, it can download the
artifact from CircleCI if you supply the build number. The script will
also download the latest version of `docker` and the version of the
`rtf` binary.

Test results will be stored in `.\tests\_results\<UUID>` directory
where `<UUID>` is the UUID printed out during the test run.

To manually run the test, make sure you have a working LCOW system set
up. You'll also need a copy of the `rtf.exe` binary (see
[`RunTests.ps1`](./tests/RunTests.ps1) on how to obtain it or `go get
..` it). Further, `docker` must also be in your path.

To run tests, use `rtf run` inside the `.\tests` directory. To list
which tests are available use `rtf list` or `rtf info`. To run an
individual test or a group of tests use `rtf run <name>`.

