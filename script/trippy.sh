#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "trippy" "https://github.com/fujiapple852/trippy/releases/latest" "trippy-{TAG}-x86_64-unknown-linux-musl" ".tar.gz" "" "trip"
