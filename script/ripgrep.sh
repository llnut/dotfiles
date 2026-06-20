#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "ripgrep" "https://github.com/BurntSushi/ripgrep/releases/latest" "ripgrep-{TAG}-x86_64-unknown-linux-musl" ".tar.gz" "" "rg"
