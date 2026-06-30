#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name bunster --repo yassinebenaid/bunster --asset bunster_linux-amd64 --ext .tar.gz
