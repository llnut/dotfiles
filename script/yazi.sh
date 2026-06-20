#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "yazi" "https://github.com/sxyazi/yazi/releases/latest" "yazi-x86_64-unknown-linux-musl" ".zip"
