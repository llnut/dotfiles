#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name nvim-nightly --repo neovim/neovim --nightly --asset nvim-linux-x86_64 --ext .tar.gz --subdir bin --bin nvim
