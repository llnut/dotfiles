#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name rustscan --repo RustScan/RustScan --asset x86_64-linux-rustscan --ext .tar.gz.zip
