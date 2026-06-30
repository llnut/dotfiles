#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name oxker --repo mrjackwills/oxker --asset oxker_linux_x86_64 --ext .tar.gz
