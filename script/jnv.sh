#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "jnv" "https://github.com/ynqa/jnv/releases/latest" "jnv-x86_64-unknown-linux-gnu" ".tar.xz"
