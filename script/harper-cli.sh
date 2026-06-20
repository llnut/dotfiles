#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "harper-cli" "https://github.com/Automattic/harper/releases/latest" "harper-cli-x86_64-unknown-linux-gnu" ".tar.gz"
