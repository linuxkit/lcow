FROM alpine:3.7

# Copy a file
COPY /Dockerfile .
COPY /test.ps1 /

# Copy a file to non-existing destination and directory
COPY /Dockerfile /bar/Dockerfile
COPY /Dockerfile /foo/bar/baz/
COPY Dockerfile test.ps1 /baz/

# Copy a directory to root or another directory
COPY folder1 /
COPY folder1 /dest1

# Copy a nested directory
COPY folder2 /
COPY folder2 /dest2/

# Relative to WORKDIR
WORKDIR /work
COPY Dockerfile .

# verify. These are separate RUN commands to make it easier to debug
RUN test -f /Dockerfile
RUN test -f /test.ps1

RUN test -f /bar/Dockerfile
RUN test -f /foo/bar/baz/Dockerfile
RUN test -f /baz/Dockerfile && test -f /baz/test.ps1

RUN test -f /Dockerfile
RUN test -f /dest1/Dockerfile

RUN test -f /folder3/test.ps1 && test -f /folder3/Dockerfile
RUN test -f /dest2/folder3/test.ps1   && test -f /dest2/folder3/Dockerfile

RUN test -f /work/Dockerfile
