-- This file can be loaded by calling `lua require('plugins')` from your init.vim
--
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
      'neovim/nvim-lspconfig',
      config = "require('plugin_config.lsp')"
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

  ----use 'nvim-telescope/telescope-file-browser.nvim'
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
  -- use { 'tpope/vim-surround' }
  use { 'feline-nvim/feline.nvim', config = function() require("feline").setup() end }
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

  ---- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim',
    after = 'plenary.nvim',
    config = "require('plugin_config.gitsigns')",
  }
  if packer_bootstrap then
    require('packer').sync()
  end

end)
