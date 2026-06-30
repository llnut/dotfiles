#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name phantun --repo dndx/phantun --asset phantun_x86_64-unknown-linux-musl --ext .zip --bin phantun_client --bin phantun_server
