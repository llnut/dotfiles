#!/bin/bash
set -x

echo "Installing neovim-nightly..."

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT_DIR="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
BIN_PATH="$CUR_DIR/../bin" && mkdir -p $BIN_PATH && mkdir -p $HOME/.local/bin
FILE="nvim-linux64.tar.gz"

source $SCRIPT_DIR/util.sh
bk $BIN_PATH/nvim-linux64
curl -o $BIN_PATH/$FILE --proto '=https' --tlsv1.2 -SLf https://github.com/neovim/neovim/releases/download/nightly/$FILE
cd $BIN_PATH && tar zxf $FILE
ln -sf $BIN_PATH/nvim-linux64/bin/nvim $HOME/.local/bin/nvim
rm -f $BIN_PATH/$FILE
