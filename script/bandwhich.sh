#!/bin/bash

APP_NAME="bandwidth"
echo "Installing ${APP_NAME}..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="$APP_NAME"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".tar.gz"
SAVE_VERSION=1
BIN_PATH="$SAVE_PATH/$SAVE_DIR"
BIN=("bandwhich")

LATEST_URL="https://github.com/imsnif/bandwhich/releases/latest"
LATEST_URL=`github_latest_url "$LATEST_URL"`
LATEST_TAG=`echo $LATEST_URL | awk -F '/' '{print $NF}'`
[ -f "$SAVE_PATH/$SAVE_DIR/.$LATEST_TAG" ] && echo "Installation successful." && exit 0
REMOTE_FILE_PREFIX="bandwhich-v${LATEST_TAG}-x86_64-unknown-linux-musl"

backup $SAVE_PATH/$SAVE_DIR
cd $SAVE_PATH

if [ -n "$SAVE_FILE_SUFFIX" ]; then
    echo 1
    download "$SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX" "$LATEST_URL/$REMOTE_FILE_PREFIX$SAVE_FILE_SUFFIX"
    wrap_decompress $SAVE_DIR $SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
    rm -f $SAVE_PATH/$SAVE_FILE_PREFIX$SAVE_FILE_SUFFIX
else
    echo 2
    mkdir -p $SAVE_PATH/$SAVE_DIR
    download "$SAVE_PATH/$SAVE_DIR/$SAVE_FILE_PREFIX" "$LATEST_URL/$REMOTE_FILE_PREFIX"
fi

circulate_ln "$BIN_PATH" "${BIN[*]}" "$LOCAL_BIN_PATH"
[ $SAVE_VERSION -eq 1 ] && touch $SAVE_DIR/.$LATEST_TAG
echo "Installation successful."

