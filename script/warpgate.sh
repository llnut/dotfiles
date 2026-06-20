#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "warpgate" "https://github.com/warp-tech/warpgate/releases/latest" "warpgate-{TAG}-x86_64-linux" ""
