#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name sccache-dist --repo mozilla/sccache --asset "sccache-dist-{TAG}-x86_64-unknown-linux-musl" --ext .tar.gz
