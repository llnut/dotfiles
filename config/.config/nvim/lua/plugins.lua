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
  use {
    'nvim-telescope/telescope.nvim',
    config = "require('plugin_config.telescope')",
    requires = {'nvim-lua/plenary.nvim'}
  }
  use {
    'nvim-telescope/telescope-ui-select.nvim',
    requires = { "nvim-telescope/telescope.nvim" },
  }

  use {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = "require('plugin_config.cmp')"
  }
  use {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'}
  use {'hrsh7th/cmp-nvim-lua', after = 'cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer', after = 'cmp-nvim-lsp'}
  use {'hrsh7th/cmp-path', after = 'cmp-nvim-lsp'}
  use {'hrsh7th/cmp-calc', after = 'cmp-nvim-lsp'}
  use {'hrsh7th/cmp-cmdline', after = 'cmp-nvim-lsp'}
  use {'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'cmp-nvim-lsp'}
  use {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = "require('plugin_config.crates')"
  }

  use {'hrsh7th/cmp-vsnip', after = 'cmp-nvim-lsp'}
  use {'hrsh7th/vim-vsnip', after = 'cmp-nvim-lsp'}

  use {
    'nvim-lualine/lualine.nvim',
    config = "require('plugin_config.lualine')"
  }
  use { 'godlygeek/tabular' }
  use { 'mg979/vim-visual-multi', branch = 'master' }
  use { 'mbbill/undotree' }
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = {'kyazdani42/nvim-web-devicons'},
    config = "require('plugin_config.bufferline')"
  }
  use { 'lambdalisue/suda.vim' }
  use { 
    'mfussenegger/nvim-dap',
    config = "require('plugin_config.nvim-dap')",
  }
  use { 'soywod/himalaya', rtp = 'vim' }
  use {
    'lewis6991/gitsigns.nvim',
    after = 'plenary.nvim',
    config = "require('plugin_config.gitsigns')",
  }
  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = "require('plugin_config.hop')",
  }
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
