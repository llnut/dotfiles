#!/bin/bash

APP_NAME="firecracker"
echo "Installing $APP_NAME..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="$APP_NAME"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".tgz"
SAVE_VERSION=1
BIN_PATH="$SAVE_PATH/$SAVE_DIR"

LATEST_URL="https://github.com/firecracker-microvm/firecracker/releases/latest"
LATEST_URL=`github_latest_url "$LATEST_URL"`
LATEST_TAG=`echo $LATEST_URL | awk -F '/' '{print $NF}'`
REMOTE_FILE_PREFIX="firecracker-${LATEST_TAG}-x86_64"

BIN=("firecracker-${LATEST_TAG}-x86_64" "jailer-${LATEST_TAG}-x86_64" "rebase-snap-${LATEST_TAG}-x86_64" "seccompiler-bin-${LATEST_TAG}-x86_64")
BIN_LINK=("firecracker" "jailer" "rebase-snap" "seccompiler-bin")

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

