#!/bin/bash
set -x

echo "Installing Rust..."
RUST_INIT="$HOME/rustup-init"
dl "$RUST_INIT" "https://sh.rustup.rs"
chmod +x $RUST_INIT && $RUST_INIT -t x86_64-unknown-linux-gnu --default-toolchain stable -y
rm -f $RUST_INIT && rm -rf $HOME/.cargo/registry $HOME/.cargo/git
