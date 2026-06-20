#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "alist" "https://github.com/alist-org/alist/releases/latest" "alist-linux-musl-amd64" ".tar.gz"
