#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "codelldb" "https://github.com/vadimcn/vscode-lldb/releases/latest" "codelldb-linux-x64" ".vsix" "extension/adapter"
