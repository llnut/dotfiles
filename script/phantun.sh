#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "phantun" "https://github.com/dndx/phantun/releases/latest" "phantun_x86_64-unknown-linux-musl" ".zip" "" "phantun_client" "phantun_server"
