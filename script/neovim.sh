#!/bin/bash

echo "Installing neovim-nightly..."

CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BIN_PATH="$CURDIR/../bin"
FILE="nvim-linux64.tar.gz"

rm -rf $BIN_PATH/nvim-linux64
curl -o $BIN_PATH/$FILE --proto '=https' --tlsv1.2 -sSLf https://github.com/neovim/neovim/releases/download/nightly/$FILE
cd $BIN_PATH && tar zxf $FILE
ln -sf $BIN_PATH/nvim-linux64/bin/nvim $HOME/.local/bin/nvim
rm -f $BIN_PATH/$FILE
