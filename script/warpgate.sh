#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name warpgate --repo warp-tech/warpgate --asset "warpgate-{TAG}-x86_64-linux"
