#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "dufs" "https://github.com/sigoden/dufs/releases/latest" "dufs-{TAG}-x86_64-unknown-linux-musl" ".tar.gz"
