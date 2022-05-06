local packer = nil
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  if vim.fn.input("Install packer.nvim? (y for yes) ") == "y" then
    --vim.api.nvim_command("!git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. install_path)
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.api.nvim_command("packadd packer.nvim")
    for i, v in ipairs(vim.api.nvim_get_runtime_file("lua/", "v:true")) do
      print(i, v)
    end
    print("Installed packer.nvim.")
  else
    return nil
  end
end

local function init()
  if packer == nil then
    packer = require('packer')
    packer.init({ disable_commands = true })
  end

  local use = packer.use
  packer.reset()

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {'lewis6991/impatient.nvim'}

  use {
    'neovim/nvim-lspconfig',
    config = "require('plugin_config.lsp')"
  }
  use {
    'williamboman/nvim-lsp-installer',
    config = "require('plugin_config.lsp_installer')"
  }

  use { 'nvim-lua/plenary.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'morhetz/gruvbox' }
  use {
    'kyazdani42/nvim-tree.lua',
    config = "require('plugin_config.tree')",
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-telescope/telescope.nvim',
    config = "require('plugin_config.telescope')",
    requires = {'nvim-lua/plenary.nvim'}
  }

  use {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = "require('plugin_config.cmp')"
  }
  use {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lua', after = 'cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer', after = 'cmp-nvim-lua'}
  use {'hrsh7th/cmp-path', after = 'cmp-buffer'}
  use {'hrsh7th/cmp-calc', after = 'cmp-path'}
  use {'hrsh7th/cmp-cmdline', after = 'cmp-calc'}
  use {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = "require('plugin_config.crates')"
  }

  use {'hrsh7th/cmp-vsnip', after = 'cmp-nvim-lsp'}
  use {'hrsh7th/vim-vsnip', after = 'cmp-nvim-lsp'}

  -- use { 'akinsho/bufferline.nvim', config = function() require("bufferline").setup {} end }
  use { 'tpope/vim-fugitive' }
  use { 
    'feline-nvim/feline.nvim',
    config = "require('plugin_config.feline')"
  }
  use { 'easymotion/vim-easymotion' }
  use { 'godlygeek/tabular' }
  use { 'mg979/vim-visual-multi', branch = 'master' }
  use { 'mbbill/undotree' }
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = "require('plugin_config.barbar')"
  }
  use { 'lambdalisue/suda.vim' }
  use { 
    'puremourning/vimspector',

    config = "require('plugin_config.vimspector')",
  }
  use { 'soywod/himalaya', rtp = 'vim' }
  use {
    'lewis6991/gitsigns.nvim',
    after = 'plenary.nvim',
    config = "require('plugin_config.gitsigns')",
  }
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
