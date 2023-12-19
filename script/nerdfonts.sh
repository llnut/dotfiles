#!/bin/bash

APP_NAME="nerdfonts"
echo "Installing ${APP_NAME}..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_DIR="$APP_NAME"
SAVE_FILE_PREFIX="$SAVE_DIR"
SAVE_FILE_SUFFIX=".tar.xz"
SAVE_VERSION=1
BIN_PATH="$SAVE_PATH/$SAVE_DIR"

LATEST_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest"
LATEST_URL=`github_latest_url "$LATEST_URL"`
LATEST_TAG=`echo $LATEST_URL | awk -F '/' '{print $NF}'`
REMOTE_FILE_PREFIX="JetBrainsMono"

BIN_SRC=(
    "JetBrainsMonoNLNerdFontMono-Bold.ttf"
    "JetBrainsMonoNLNerdFontMono-BoldItalic.ttf"
    "JetBrainsMonoNLNerdFontMono-Italic.ttf"
    "JetBrainsMonoNLNerdFontMono-Regular.ttf"
)
BIN_DST=($BIN)

if [ -f "$SAVE_PATH/$SAVE_DIR/.$LATEST_TAG" ]; then
    install_fonts "$BIN_PATH" "${BIN_SRC[*]}" "${BIN_DST[*]}" "${LOCAL_SHARE_PATH}/fonts"
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

install_fonts "$BIN_PATH" "${BIN_SRC[*]}" "${BIN_DST[*]}" "${LOCAL_SHARE_PATH}/fonts"
[ $SAVE_VERSION -eq 1 ] && touch $SAVE_DIR/.$LATEST_TAG
echo "Installation successful."

