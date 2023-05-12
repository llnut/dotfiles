return {
  { 'nvim-lua/plenary.nvim' },
  { 'kyazdani42/nvim-web-devicons' },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('plugin.gruvbox')
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {
      "NvimTreeOpen",
      "NvimTreeClose",
      "NvimTreeToggle",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
    },
    keys = {
      { "<leader>d", "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", desc = "NvimTree" },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    build = ':TSUpdate',
    config = function()
      require('plugin.nvim-treesitter')
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = function()
      require('plugin.telescope')
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require('plugin.lsp')
    end,
    servers = nil,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require('plugin.cmp')
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
  },
  {
    'saecki/crates.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugin.crates')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    config = function()
      require('plugin.lualine')
    end,
  },
  {
    'akinsho/bufferline.nvim',
    lazy = false,
    version = "*",
    dependencies = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require('plugin.bufferline')
    end,
  },
  {
    'mfussenegger/nvim-dap',
    event = "LspAttach",
    config = function()
      require('plugin.nvim-dap')
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('plugin.gitsigns')
    end,
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    keys = {
      "f",
      "t",
      "w",
      "<leader><leader>f",
      "<leader><leader>F",
      "<leader><leader>w",
      "<leader><leader>W",
      "<leader><leader>p",
      "<leader><leader>P",
    },
    config = function()
      require('plugin.hop')
    end,
  },
  {
    "echasnovski/mini.align",
    lazy = false,
    version = false,
    config = function()
      require("mini.align").setup()
    end,
  },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup()
    end,
  },
  {
    "LudoPinelli/comment-box.nvim",
    cmd = {
      "CBllbox",
      "CBlcbox",
      "CBlrbox",
      "CBclbox",
      "CBccbox",
      "CBcrbox",
      "CBrlbox",
      "CBrcbox",
      "CBrrbox",
      "CBalbox",
      "CBacbox",
      "CBarbox",
    },
  },
  { 'MunifTanjim/nui.nvim' },
  {
    'Bryley/neoai.nvim',
    dependencies = {'MunifTanjim/nui.nvim'},
    cmd = {
      "NeoAI",
      "NeoAIOpen",
      "NeoAIClose",
      "NeoAIToggle",
      "NeoAIContext",
      "NeoAIContextOpen",
      "NeoAIContextClose",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
    },
    keys = {
      { "<leader>as", desc = "summarize text" },
      { "<leader>ag", desc = "generate git message" },
    },
    config = function()
      require("neoai").setup()
    end,
  }
}
