#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "gping" "https://github.com/orf/gping/releases/latest" "gping-Linux-musl-x86_64" ".tar.gz"
