#!/usr/bin/env bash

set -eux

cd "$(dirname "$0")"
./build.sh
./build-minirootfs.sh
./build-shells.sh
