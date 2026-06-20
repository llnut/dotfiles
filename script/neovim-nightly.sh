#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install -n "nvim-nightly" "https://github.com/neovim/neovim/releases/download/nightly" "nvim-linux-x86_64" ".tar.gz" "bin" "nvim"
