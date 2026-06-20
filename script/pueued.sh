#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "pueued" "https://github.com/Nukesor/pueue/releases/latest" "pueued-x86_64-unknown-linux-musl" ""
