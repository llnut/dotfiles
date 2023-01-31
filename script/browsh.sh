#!/bin/bash

echo "Installing browsh..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="browsh"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=""
BIN_PATH="$SAVE_PATH/$SAVE_DIR"
BIN=("browsh")

LATEST_URL="https://github.com/browsh-org/browsh/releases/latest"
LATEST_URL=`github_latest_url "$LATEST_URL"`
LATEST_TAG=`echo $LATEST_URL | awk -F '/' '{print $NF}' | awk -F 'v' '{print $NF}'`
[ -f "$SAVE_PATH/$SAVE_DIR/.$LATEST_TAG" ] && echo "Installation successful." && exit 0
REMOTE_FILE_PREFIX="browsh_${LATEST_TAG}_linux_amd64"

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
touch $SAVE_DIR/.$LATEST_TAG
echo "Installation successful."

