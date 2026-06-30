#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name yay --repo Jguer/yay --asset "yay_{VERSION}_x86_64" --ext .tar.gz
