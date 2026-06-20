#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "hyperfine" "https://github.com/sharkdp/hyperfine/releases/latest" "hyperfine-{TAG}-x86_64-unknown-linux-gnu" ".tar.gz"
