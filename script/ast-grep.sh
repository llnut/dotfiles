#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "ast-grep" "https://github.com/ast-grep/ast-grep/releases/latest" "app-x86_64-unknown-linux-gnu" ".zip" "" "sg:ast-grep"
