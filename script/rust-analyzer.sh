#!/bin/bash

echo "Installing rust-analyzer..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="rust-analyzer"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".gz"
BIN_PATH="$SAVE_PATH/$SAVE_DIR"
BIN=("rust-analyzer")

LATEST_URL="https://github.com/rust-lang/rust-analyzer/releases/download/nightly"
REMOTE_FILE_PREFIX="rust-analyzer-x86_64-unknown-linux-gnu"

backup $SAVE_PATH/$SAVE_DIR
cd $SAVE_PATH

if [ -n "$SAVE_FILE_SUFFIX" ]; then
    download "$SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX" "$LATEST_URL/$REMOTE_FILE_PREFIX$SAVE_FILE_SUFFIX"
    wrap_decompress $SAVE_DIR $SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
    rm -f $SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
else
    mkdir -p $SAVE_PATH/$SAVE_DIR
    download "$SAVE_PATH/$SAVE_DIR/$SAVE_FILE_PREFIX" "$LATEST_URL/$REMOTE_FILE_PREFIX"
fi

circulate_ln "$BIN_PATH" "${BIN[*]}" "$LOCAL_BIN_PATH"
echo "Installation successful."

