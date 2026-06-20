#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "mise" "https://github.com/jdx/mise/releases/latest" "mise-{TAG}-linux-x64-musl" ".tar.gz" "bin"
