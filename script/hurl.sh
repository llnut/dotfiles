#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "hurl" "https://github.com/Orange-OpenSource/hurl/releases/latest" "hurl-{TAG}-x86_64-unknown-linux-gnu" ".tar.gz" "" "hurl" "hurlfmt"
