#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name firecracker --repo firecracker-microvm/firecracker \
    --asset "firecracker-{TAG}-x86_64" --ext .tgz \
    --bin "firecracker-{TAG}-x86_64:firecracker" \
    --bin "jailer-{TAG}-x86_64:jailer" \
    --bin "rebase-snap-{TAG}-x86_64:rebase-snap" \
    --bin "seccompiler-bin-{TAG}-x86_64:seccompiler-bin"
