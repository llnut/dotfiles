#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name fd --repo sharkdp/fd --asset "fd-{TAG}-x86_64-unknown-linux-gnu" --ext .tar.gz
