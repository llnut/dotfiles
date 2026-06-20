#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
main() {
    local _dl _tag
    _dl=$(github_latest_url "https://github.com/acmesh-official/acme.sh/releases/latest") || return 1
    _tag="${_dl##*/}"
    gh_install -t "$_tag" "acme.sh" "https://github.com/acmesh-official/acme.sh/archive/refs/tags" "$_tag" ".tar.gz" "" "acme.sh"
}
main "$@"
