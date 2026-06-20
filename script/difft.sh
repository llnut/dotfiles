#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "difftastic" "https://github.com/Wilfred/difftastic/releases/latest" "difft-x86_64-unknown-linux-gnu" ".tar.gz" "" "difft"
