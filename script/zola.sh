#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "zola" "https://github.com/getzola/zola/releases/latest" "zola-{TAG}-x86_64-unknown-linux-gnu" ".tar.gz"
