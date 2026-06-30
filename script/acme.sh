#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name acme.sh --repo acmesh-official/acme.sh \
    --url https://github.com/acmesh-official/acme.sh/archive/refs/tags \
    --asset "{TAG}" --ext .tar.gz --bin acme.sh
