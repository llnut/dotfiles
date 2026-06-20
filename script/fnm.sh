#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "fnm" "https://github.com/Schniz/fnm/releases/latest" "fnm-linux" ".zip"
