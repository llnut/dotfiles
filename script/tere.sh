#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name tere --repo mgunyho/tere --asset "tere-{VERSION}-x86_64-unknown-linux-musl" --ext .zip
