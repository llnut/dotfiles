#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "zellij" "https://github.com/zellij-org/zellij/releases/latest" "zellij-x86_64-unknown-linux-musl" ".tar.gz"
