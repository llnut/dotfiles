return {
  { 'nvim-lua/plenary.nvim' },
  { 'kyazdani42/nvim-web-devicons' },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function() require("mason").setup() end,
  },
  {
    "echasnovski/mini.align",
    lazy = false,
    version = false,
    config = function() require("mini.align").setup() end,
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
}
