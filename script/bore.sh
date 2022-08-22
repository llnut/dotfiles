#!/bin/bash

echo "Installing bore..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="bore"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".tar.gz"
BIN_PATH="$SAVE_PATH/$SAVE_DIR"
BIN=("bore")

backup $SAVE_PATH/$SAVE_DIR

LATEST_URL="https://github.com/ekzhang/bore/releases/latest"
LATEST_URL=`github_latest_url "$LATEST_URL"`
LATEST_TAG=`echo $LATEST_URL | awk -F '/' '{print $NF}'`
REMOTE_FILE_PREFIX="bore-${LATEST_TAG}-x86_64-unknown-linux-musl"
download "$SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX" "$LATEST_URL/$REMOTE_FILE_PREFIX$SAVE_FILE_SUFFIX"

cd $SAVE_PATH && wrap_decompress $SAVE_DIR $SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
circulate_ln "$BIN_PATH" "${BIN[*]}" "$LOCAL_BIN_PATH"
rm -f $SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
