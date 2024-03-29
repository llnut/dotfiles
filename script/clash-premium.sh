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

LATEST_URL="https://github.com/Dreamacro/clash/releases/tag/premium"
LATEST_TAG=`curl -fSL ${LATEST_URL} | grep "<title>Release Premium" | awk -F ' ' '{print $3}'`
LATEST_URL="https://github.com/Dreamacro/clash/releases/download/premium"
REMOTE_FILE_PREFIX="clash-linux-amd64-v3-${LATEST_TAG}"

BIN=("clash-premium")
BIN_LINK=($BIN)

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

