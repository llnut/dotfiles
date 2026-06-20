#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "bore" "https://github.com/ekzhang/bore/releases/latest" "bore-{TAG}-x86_64-unknown-linux-musl" ".tar.gz"
