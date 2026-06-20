#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install -n "rust-analyzer" "https://github.com/rust-lang/rust-analyzer/releases/download/nightly" "rust-analyzer-x86_64-unknown-linux-gnu" ".gz"
