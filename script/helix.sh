#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name helix --repo helix-editor/helix --asset "helix-{TAG}-x86_64-linux" --ext .tar.xz --bin hx
