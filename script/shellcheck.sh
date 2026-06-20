#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "shellcheck" "https://github.com/koalaman/shellcheck/releases/latest" "shellcheck-{TAG}.linux.x86_64" ".tar.xz"
