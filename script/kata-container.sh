#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name kata-container --repo kata-containers/kata-containers \
    --asset "kata-static-{TAG}-x86_64" --ext .tar.xz --subdir opt/kata/bin \
    --bin cloud-hypervisor --bin containerd-shim-kata-v2 --bin firecracker --bin jailer \
    --bin kata-collect-data.sh --bin kata-monitor --bin kata-runtime --bin qemu-system-x86_64
