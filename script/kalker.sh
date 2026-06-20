#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
main() {
    local _dl
    _dl=$(github_latest_url "https://github.com/PaddiM8/kalker/releases/latest") || return 1
    gh_install "kalker" "$_dl" "kalker-linux" ""
}
main "$@"
