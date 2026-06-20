#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
main() {
    local _dl _ver
    _dl=$(github_latest_url "https://github.com/browsh-org/browsh/releases/latest") || return 1
    _ver="${_dl##*/v}"
    gh_install "browsh" "$_dl" "browsh_${_ver}_linux_amd64" ""
}
main "$@"
