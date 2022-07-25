#!/bin/bash

echo "Installing tere..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="tere"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".zip"
BIN_PATH="$SAVE_PATH/$SAVE_DIR"
BIN=("tere")

backup $SAVE_PATH/$SAVE_DIR

LATEST_URL="https://github.com/mgunyho/tere/releases/latest"
LATEST_URL=`github_latest_url "$LATEST_URL"`
LATEST_TAG=`echo $LATEST_URL | awk -F '/' '{print $NF}' | awk -F 'v' '{print $NF}'`
REMOTE_FILE_PREFIX="tere-${LATEST_TAG}-x86_64-unknown-linux-gnu"
download "$SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX" "$LATEST_URL/$REMOTE_FILE_PREFIX$SAVE_FILE_SUFFIX"

cd $SAVE_PATH && wrap_decompress $SAVE_DIR $SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
circulate_ln "$BIN_PATH" "${BIN[*]}" "$LOCAL_BIN_PATH"
rm -f $SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX

