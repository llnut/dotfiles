#!/bin/bash

APP_NAME="clash-premium"
echo "Installing ${APP_NAME}..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="$APP_NAME"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".gz"
SAVE_VERSION=1
BIN_PATH="$SAVE_PATH/$SAVE_DIR"
BIN=("clash-premium")

LATEST_URL="https://release.dreamacro.workers.dev/latest/"
LATEST_TAG="latest"
REMOTE_FILE_PREFIX="clash-linux-amd64-v3-${LATEST_TAG}"

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
[ $SAVE_VERSION -eq 1 ] && touch $SAVE_DIR/.$LATEST_TAG
echo "Installation successful."

