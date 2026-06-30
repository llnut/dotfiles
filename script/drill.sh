#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name drill --repo fcsonline/drill --asset "drill_{TAG}_x86_64-unknown-linux-musl" --ext .tar.gz --bin drill:drill-rs
