#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "shadowsocks" "https://github.com/shadowsocks/shadowsocks-rust/releases/latest" \
    "shadowsocks-{TAG}.x86_64-unknown-linux-musl" ".tar.xz" "" \
    "sslocal" "ssserver" "ssservice" "ssmanager" "ssurl"
