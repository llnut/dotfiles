-- Basic settings
require('config.option')

-- Plugin manager
require('config.lazy')

-- LSP configuration
require('config.lsp').setup()
require('config.lsp-enable')

-- Utilities and keymaps
require('util.function')
require('config.autocmd')
require('config.keymap')
