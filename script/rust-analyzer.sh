#!/bin/bash

echo "Installing rust-analyzer..."
CURDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BIN_PATH="$CURDIR/../bin"
FILE="rust-analyzer-x86_64-unknown-linux-gnu.gz"
rm -rf $BIN_PATH/rust-analyzer-x86_64-unknown-linux-gnu
curl -o $BIN_PATH/$FILE --proto '=https' --tlsv1.2 -sSLf https://github.com/rust-lang/rust-analyzer/releases/download/2022-04-18/$FILE
cd $BIN_PATH && gzip -d $FILE
chmod +x $BIN_PATH/rust-analyzer-x86_64-unknown-linux-gnu
ln -sf $BIN_PATH/rust-analyzer-x86_64-unknown-linux-gnu $HOME/.local/bin/rust-analyzer
