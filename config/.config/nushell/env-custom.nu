$env.PATH = ($env.PATH | split row (char esep) | append [$"($env.HOME)/.local/bin"])

$env.COLORTERM = 'truecolor'
$env.LANG = 'en_US.UTF-8'
$env.LC_ALL = 'en_US.UTF-8'
$env.EDITOR = 'nvim'
$env.DOTFILES = $"($env.HOME)/.dotfiles"
$env.DOTFILES_BIN = $"($env.HOME)/.dotfiles-bin"
