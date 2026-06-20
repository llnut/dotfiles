#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "hawkeye" "https://github.com/korandoru/hawkeye/releases/latest" "hawkeye-x86_64-unknown-linux-gnu" ".tar.xz"
