#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name fend --repo printfn/fend --asset "fend-{VERSION}-linux-x86_64-musl" --ext .zip
