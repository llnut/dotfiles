#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name tmux-mcp --repo bnomei/tmux-mcp --asset "tmux-mcp-rs-{TAG}-x86_64-unknown-linux-musl" --ext .tar.gz --bin tmux-mcp-rs:tmux-mcp
