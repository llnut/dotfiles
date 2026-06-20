#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "starship" "https://github.com/starship/starship/releases/latest" "starship-x86_64-unknown-linux-gnu" ".tar.gz"
