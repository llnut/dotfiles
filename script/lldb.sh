#!/bin/bash

echo "Installing vscode-lldb..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="codelldb"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".vsix"
BIN_PATH="$SAVE_PATH/$SAVE_DIR/extension/adapter"
BIN=("codelldb")

backup $SAVE_PATH/$SAVE_DIR

#LATEST_URL="https://github.com/vadimcn/vscode-lldb/releases/latest"
#LATEST_URL=`github_latest_url "$LATEST_URL"`
#LATEST_TAG=`echo $LATEST_URL | awk -F '/' '{print $NF}'`
#REMOTE_FILE_PREFIX="codelldb-x86_64-linux"
#download "$SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX" "$LATEST_URL/$REMOTE_FILE_PREFIX$SAVE_FILE_SUFFIX"

cd $SAVE_PATH && wrap_decompress $SAVE_DIR $SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
circulate_ln "$BIN_PATH" "${BIN[*]}" "$LOCAL_BIN_PATH"
#rm -f $SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX

