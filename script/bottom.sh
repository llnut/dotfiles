#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install -n "bottom-nightly" "https://github.com/ClementTsang/bottom/releases/download/nightly" "bottom_x86_64-unknown-linux-gnu" ".tar.gz" "" "btm"
