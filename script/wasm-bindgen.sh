#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "wasm-bindgen" "https://github.com/rustwasm/wasm-bindgen/releases/latest" "wasm-bindgen-{TAG}-x86_64-unknown-linux-musl" ".tar.gz"
