#!/bin/bash

echo "Installing clash..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="clash"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".gz"
BIN_PATH="$SAVE_PATH/$SAVE_DIR"
BIN=("clash")

LATEST_URL="https://github.com/Dreamacro/clash/releases/latest"
LATEST_URL=`github_latest_url "$LATEST_URL"`
LATEST_TAG=`echo $LATEST_URL | awk -F '/' '{print $NF}'`
[ -f "$SAVE_PATH/$SAVE_DIR/.$LATEST_TAG" ] && echo "Installation successful." && exit 0
REMOTE_FILE_PREFIX="clash-linux-amd64-v3-${LATEST_TAG}"
download "$SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX" "$LATEST_URL/$REMOTE_FILE_PREFIX$SAVE_FILE_SUFFIX"

backup $SAVE_PATH/$SAVE_DIR

cd $SAVE_PATH && wrap_decompress $SAVE_DIR $SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
circulate_ln "$BIN_PATH" "${BIN[*]}" "$LOCAL_BIN_PATH"
touch $SAVE_DIR/.$LATEST_TAG
rm -f $SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
echo "Installation successful."

