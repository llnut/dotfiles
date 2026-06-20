#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "drill" "https://github.com/fcsonline/drill/releases/latest" "drill_{TAG}_x86_64-unknown-linux-musl" ".tar.gz" "" "drill:drill-rs"
