#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name hurl --repo Orange-OpenSource/hurl --asset "hurl-{TAG}-x86_64-unknown-linux-gnu" --ext .tar.gz --bin hurl --bin hurlfmt
