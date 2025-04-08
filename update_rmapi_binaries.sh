#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

#git clone git@github.com:DelusionalLogic/rmapi.git
git clone git@github.com:ddvk/rmapi.git
cd rmapi || exit
git fetch
git switch parse_schema4
#git checkout "$(git tag --sort=-creatordate | head -n 1)"

move() {
  mv rmapi "${SCRIPT_DIR}"/src/main/jib/usr/local/bin/rmapi_"${1}"
}

CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build && move "aarch64"
CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=5 go build && move "arm"
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build && move "amd64"

cd - || exit
#rm -rf rmapi
