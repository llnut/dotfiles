#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "bandwidth" "https://github.com/imsnif/bandwhich/releases/latest" "bandwhich-{TAG}-x86_64-unknown-linux-musl" ".tar.gz" "" "bandwhich"
