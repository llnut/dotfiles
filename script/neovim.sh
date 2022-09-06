#!/bin/bash

echo "Installing neovim-nightly..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="nvim"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".tar.gz"
BIN_PATH="$SAVE_PATH/$SAVE_DIR/bin"
BIN=("nvim")

LATEST_URL="https://github.com/neovim/neovim/releases/download/nightly"
REMOTE_FILE_PREFIX="nvim-linux64"
download "$SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX" "$LATEST_URL/$REMOTE_FILE_PREFIX$SAVE_FILE_SUFFIX"

backup $SAVE_PATH/$SAVE_DIR

cd $SAVE_PATH && wrap_decompress $SAVE_DIR $SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
circulate_ln "$BIN_PATH" "${BIN[*]}" "$LOCAL_BIN_PATH"
rm -f $SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
echo "Installation successful."

