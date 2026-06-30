#!/bin/bash
SCRIPT_PATH=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_PATH/util.sh"
gh_install_fonts --name nerdfonts --repo ryanoasis/nerd-fonts --asset JetBrainsMono --ext .tar.xz \
    --font JetBrainsMonoNLNerdFontMono-Bold.ttf \
    --font JetBrainsMonoNLNerdFontMono-BoldItalic.ttf \
    --font JetBrainsMonoNLNerdFontMono-Italic.ttf \
    --font JetBrainsMonoNLNerdFontMono-Regular.ttf
