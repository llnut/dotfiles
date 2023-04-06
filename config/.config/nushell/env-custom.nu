
#let-env PATH = ($env.PATH | split row (char esep) | append [$"($env.HOME)/.cargo/bin", $"($env.HOME)/.local/bin"])
let-env PATH = ($env.PATH | split row (char esep) | append [$"($env.HOME)/.local/bin"])

let-env COLORTERM = 'truecolor'
let-env LANG = 'en_US.UTF-8'
let-env LC_ALL = 'en_US.UTF-8'
let-env EDITOR = 'nvim'
let-env DOTFILES = $"($env.HOME)/.dotfiles"

