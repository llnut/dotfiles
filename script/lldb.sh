#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name codelldb --repo vadimcn/vscode-lldb --asset codelldb-linux-x64 --ext .vsix --subdir extension/adapter
