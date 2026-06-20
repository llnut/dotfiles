#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "postman2openapi" "https://github.com/kevinswiber/postman2openapi/releases/latest" "postman2openapi-{TAG}-x86_64-unknown-linux-musl" ".tar.gz"
