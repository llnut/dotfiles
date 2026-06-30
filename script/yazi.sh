#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name yazi --repo sxyazi/yazi --asset yazi-x86_64-unknown-linux-musl --ext .zip
