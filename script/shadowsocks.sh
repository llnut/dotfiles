#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name shadowsocks --repo shadowsocks/shadowsocks-rust \
    --asset "shadowsocks-{TAG}.x86_64-unknown-linux-musl" --ext .tar.xz \
    --bin sslocal --bin ssserver --bin ssservice --bin ssmanager --bin ssurl
