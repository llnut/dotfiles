#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
main() {
    local _dl _ver
    _dl=$(github_latest_url "https://github.com/svenstaro/miniserve/releases/latest") || return 1
    _ver="${_dl##*/v}"
    gh_install "miniserve" "$_dl" "miniserve-${_ver}-x86_64-unknown-linux-musl" ""
}
main "$@"
