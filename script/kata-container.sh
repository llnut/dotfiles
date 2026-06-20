#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "kata-container" "https://github.com/kata-containers/kata-containers/releases/latest" \
    "kata-static-{TAG}-x86_64" ".tar.xz" "opt/kata/bin" \
    "cloud-hypervisor" "containerd-shim-kata-v2" "firecracker" "jailer" \
    "kata-collect-data.sh" "kata-monitor" "kata-runtime" "qemu-system-x86_64"
