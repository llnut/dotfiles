#!/bin/bash
set -x

echo "Installing vscode-lldb..."

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
BIN_PATH="$CUR_DIR/../bin" && mkdir -p $BIN_PATH
FILE="codelldb-x86_64-linux.vsix"

source $SCRIPT_DIR/util.sh
bk $BIN_PATH/codelldb-x86_64-linux
curl -o $BIN_PATH/$FILE --proto '=https' --tlsv1.2 -SLf https://github.com/vadimcn/vscode-lldb/releases/download/v1.7.0/$FILE
cd $BIN_PATH && unzip $FILE -d codelldb-x86_64-linux
rm -f $BIN_PATH/$FILE
