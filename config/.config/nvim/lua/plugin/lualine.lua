return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  opts = {
    thems = 'gruvbox'
  },
  config = function(_, opts)
    require('lualine').setup(opts)
  end,
}
