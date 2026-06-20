#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "cargo-generate" "https://github.com/cargo-generate/cargo-generate/releases/latest" "cargo-generate-{TAG}-x86_64-unknown-linux-musl" ".tar.gz"
