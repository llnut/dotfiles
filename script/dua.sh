#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "dua" "https://github.com/Byron/dua-cli/releases/latest" "dua-{TAG}-x86_64-unknown-linux-musl" ".tar.gz"
