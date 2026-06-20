#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "satpaper" "https://github.com/Colonial-Dev/satpaper/releases/latest" "satpaper-x86_64-unknown-linux-musl" ""
