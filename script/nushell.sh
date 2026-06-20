#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install "nushell" "https://github.com/nushell/nushell/releases/latest" "nu-{TAG}-x86_64-unknown-linux-musl" ".tar.gz" "" \
    "nu" "nu_plugin_custom_values" "nu_plugin_example" "nu_plugin_formats" \
    "nu_plugin_gstat" "nu_plugin_inc" "nu_plugin_query" "nu_plugin_polars" \
    "nu_plugin_stress_internals"
