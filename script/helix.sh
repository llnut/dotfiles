#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "helix" "https://github.com/helix-editor/helix/releases/latest" "helix-{TAG}-x86_64-linux" ".tar.xz" "" "hx"
