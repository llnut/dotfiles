#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "atuin" "https://github.com/ellie/atuin/releases/latest" "atuin-x86_64-unknown-linux-musl" ".tar.gz"
