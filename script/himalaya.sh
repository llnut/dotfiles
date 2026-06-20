#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "himalaya" "https://github.com/soywod/himalaya/releases/latest" "himalaya.x86_64-linux" ".tgz"
