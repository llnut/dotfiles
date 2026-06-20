#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "oxker" "https://github.com/mrjackwills/oxker/releases/latest" "oxker_linux_x86_64" ".tar.gz"
