#!/bin/bash

APP_NAME="yazi"
echo "Installing ${APP_NAME}..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="$APP_NAME"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".zip"
SAVE_VERSION=1
BIN_PATH="$SAVE_PATH/$SAVE_DIR"

LATEST_URL="https://github.com/sxyazi/yazi/releases/download"
LATEST_TAG="v0.1.4"
LATEST_URL="${LATEST_URL}/${LATEST_TAG}"
REMOTE_FILE_PREFIX="yazi-x86_64-unknown-linux-gnu"

BIN=("yazi-x86_64-unknown-linux-gnu")
BIN_LINK=("yazi")

if [ -f "$SAVE_PATH/$SAVE_DIR/.$LATEST_TAG" ]; then
    circulate_ln "$BIN_PATH" "${BIN[*]}" "${BIN_LINK[*]}" "$LOCAL_BIN_PATH"
    echo "Installation successful."
    exit 0
fi

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

circulate_ln "$BIN_PATH" "${BIN[*]}" "${BIN_LINK[*]}" "$LOCAL_BIN_PATH"
[ $SAVE_VERSION -eq 1 ] && touch $SAVE_DIR/.$LATEST_TAG
echo "Installation successful."

