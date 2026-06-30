#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name shfmt --repo mvdan/sh --asset "shfmt_{TAG}_linux_amd64"
