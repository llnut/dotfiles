#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name ast-grep --repo ast-grep/ast-grep --asset app-x86_64-unknown-linux-gnu --ext .zip --bin sg:ast-grep
