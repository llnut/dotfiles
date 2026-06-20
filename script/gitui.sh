#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "gitui" "https://github.com/extrawurst/gitui/releases/latest" "gitui-linux-x86_64" ".tar.gz"
