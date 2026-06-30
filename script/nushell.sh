#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install --name nushell --repo nushell/nushell --asset "nu-{TAG}-x86_64-unknown-linux-musl" --ext .tar.gz \
    --bin nu --bin nu_plugin_custom_values --bin nu_plugin_example --bin nu_plugin_formats \
    --bin nu_plugin_gstat --bin nu_plugin_inc --bin nu_plugin_query --bin nu_plugin_polars \
    --bin nu_plugin_stress_internals
