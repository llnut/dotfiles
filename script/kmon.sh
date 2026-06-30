#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name kmon --repo orhun/kmon --asset "kmon-{VERSION}-x86_64-unknown-linux-gnu" --ext .tar.gz
