#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name gitui --repo extrawurst/gitui --asset gitui-linux-x86_64 --ext .tar.gz
