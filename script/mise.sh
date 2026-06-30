#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name mise --repo jdx/mise --asset "mise-{TAG}-linux-x64-musl" --ext .tar.gz --subdir bin
