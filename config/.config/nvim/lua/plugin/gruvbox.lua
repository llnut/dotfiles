-- Official documentation: https://github.com/ellisonleao/gruvbox.nvim
return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  opts = { contrast = "soft" },
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
}
