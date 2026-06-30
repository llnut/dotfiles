#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name zoxide --repo ajeetdsouza/zoxide --asset "zoxide-{VERSION}-x86_64-unknown-linux-musl" --ext .tar.gz
