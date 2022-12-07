#!/bin/bash

echo "Installing clash-premium..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="clash-premium"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".gz"
BIN_PATH="$SAVE_PATH/$SAVE_DIR"
BIN=("clash-premium")

LATEST_URL="https://release.dreamacro.workers.dev/latest/"
LATEST_TAG="latest"
[ -f "$SAVE_PATH/$SAVE_DIR/.$LATEST_TAG" ] && echo "Installation successful." && exit 0
REMOTE_FILE_PREFIX="clash-linux-amd64-v3-${LATEST_TAG}"
download "$SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX" "$LATEST_URL/$REMOTE_FILE_PREFIX$SAVE_FILE_SUFFIX"

backup $SAVE_PATH/$SAVE_DIR

cd $SAVE_PATH && wrap_decompress $SAVE_DIR $SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
circulate_ln "$BIN_PATH" "${BIN[*]}" "$LOCAL_BIN_PATH"
touch $SAVE_DIR/.$LATEST_TAG
rm -f $SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
echo "Installation successful."

