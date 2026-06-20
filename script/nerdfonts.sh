#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install_fonts "nerdfonts" "https://github.com/ryanoasis/nerd-fonts/releases/latest" "JetBrainsMono" ".tar.xz" \
    "JetBrainsMonoNLNerdFontMono-Bold.ttf" \
    "JetBrainsMonoNLNerdFontMono-BoldItalic.ttf" \
    "JetBrainsMonoNLNerdFontMono-Italic.ttf" \
    "JetBrainsMonoNLNerdFontMono-Regular.ttf"
