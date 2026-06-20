#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "bunster" "https://github.com/yassinebenaid/bunster/releases/latest" "bunster_linux-amd64" ".tar.gz"
