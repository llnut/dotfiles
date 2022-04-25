#!/bin/bash
set -x

echo "Installing packer.nvim..."

BIN_PATH=$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
rm -rf $BIN_PATH
git clone --depth 1 https://github.com/wbthomason/packer.nvim $BIN_PATH
