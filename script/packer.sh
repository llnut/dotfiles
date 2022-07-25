#!/bin/bash
set -x

echo "Installing packer.nvim..."

SCRIPT_DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
BIN_DIR=$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim && mkdir -p $BIN_DIR

source $SCRIPT_DIR/util.sh
bk $BIN_DIR
git clone --depth 1 https://github.com/wbthomason/packer.nvim $BIN_DIR
