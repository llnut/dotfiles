#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "sccache-dist" "https://github.com/mozilla/sccache/releases/latest" "sccache-dist-{TAG}-x86_64-unknown-linux-musl" ".tar.gz"
