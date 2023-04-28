local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'williamboman/mason.nvim',
    config = "require('plugin_config.mason')"
  }

  use { 'nvim-lua/plenary.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use {
    'ellisonleao/gruvbox.nvim',
    config = "require('plugin_config.gruvbox')"
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = "require('plugin_config.nvim-tree')",
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = "require('plugin_config.nvim-treesitter')",
  }
  use {'nvim-telescope/telescope-ui-select.nvim'}
  use {
    'nvim-telescope/telescope.nvim',
    config = "require('plugin_config.telescope')",
    requires = {'nvim-lua/plenary.nvim'},
    after = 'telescope-ui-select.nvim'
  }
  use {'rafamadriz/friendly-snippets'}
  use {
    'neovim/nvim-lspconfig',
    config = "require('plugin_config.lsp')"
  }
  use {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = "require('plugin_config.cmp')"
  }
  use {'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp'}
  use {'hrsh7th/cmp-buffer', after = 'nvim-cmp'}
  use {'hrsh7th/cmp-path', after = 'nvim-cmp'}
  use {'hrsh7th/cmp-calc', after = 'nvim-cmp'}
  use {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp'}
  use {'hrsh7th/cmp-vsnip', after = 'nvim-cmp'}
  use {'hrsh7th/vim-vsnip', after = 'nvim-cmp'}
  use {
    'saecki/crates.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = "require('plugin_config.crates')"
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = "require('plugin_config.lualine')"
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = {'kyazdani42/nvim-web-devicons'},
    config = "require('plugin_config.bufferline')"
  }
  use { 'lambdalisue/suda.vim' }
  use {
    'mfussenegger/nvim-dap',
    config = "require('plugin_config.nvim-dap')",
  }
  use {
    'lewis6991/gitsigns.nvim',
    after = 'plenary.nvim',
    config = "require('plugin_config.gitsigns')",
  }
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = "require('plugin_config.hop')",
  }
  use {'MunifTanjim/nui.nvim'}
  use {
    'Bryley/neoai.nvim',
    after = 'nui.nvim',
    require = {'MunifTanjim/nui.nvim'},
    config = "require('plugin_config.neoai')",
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
