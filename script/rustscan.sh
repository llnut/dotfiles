#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "rustscan" "https://github.com/RustScan/RustScan/releases/latest" "x86_64-linux-rustscan" ".tar.gz.zip"
