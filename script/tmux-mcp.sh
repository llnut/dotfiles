#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "tmux-mcp" "https://github.com/bnomei/tmux-mcp/releases/latest" "tmux-mcp-rs-{TAG}-x86_64-unknown-linux-musl" ".tar.gz" "" "tmux-mcp-rs:tmux-mcp"
