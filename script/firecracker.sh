#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "firecracker" "https://github.com/firecracker-microvm/firecracker/releases/latest" \
    "firecracker-{TAG}-x86_64" ".tgz" "" \
    "firecracker-{TAG}-x86_64:firecracker" \
    "jailer-{TAG}-x86_64:jailer" \
    "rebase-snap-{TAG}-x86_64:rebase-snap" \
    "seccompiler-bin-{TAG}-x86_64:seccompiler-bin"
