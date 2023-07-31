#!/bin/bash

echo "Installing packer.nvim..."

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
source $SCRIPT_PATH/util.sh

SAVE_PATH="$HOME/.local/share/nvim/site/pack/packer/start"
SAVE_DIR="packer.nvim"

backup $SAVE_PATH/$SAVE_DIR
git clone --depth 1 https://github.com/wbthomason/packer.nvim $SAVE_PATH/$SAVE_DIR
