return {
  {
    "mason-org/mason.nvim",
    -- Loaded at startup: setup() puts the mason bin directory on PATH before
    -- any language server starts.
    lazy = false,
    opts = {},
  },
  {
    "nvim-mini/mini.align",
    version = false,
    opts = {},
  },
  {
    "nvim-mini/mini.diff",
    version = false,
    opts = {
      -- Show hunks in the sign column instead of colouring line numbers
      view = {
        style = "sign",
        signs = { add = "┃", change = "┃", delete = "_" },
      },
      -- Only the gutter marks are wanted; hunk operators and motions stay off
      mappings = {
        apply = "",
        reset = "",
        textobject = "",
        goto_first = "",
        goto_prev = "",
        goto_next = "",
        goto_last = "",
      },
    },
  },
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
