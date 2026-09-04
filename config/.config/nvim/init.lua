-- Basic settings
require('config.option')

-- Plugin manager
require('config.lazy')

-- LSP configuration
require('config.lsp').setup()

-- Autocommands and keymaps
require('config.autocmd')
require('config.keymap')
