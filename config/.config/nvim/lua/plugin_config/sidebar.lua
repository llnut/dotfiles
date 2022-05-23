require("sidebar-nvim").setup({
  disable_default_keybindings = 0,
  bindings = nil,
  open = false,
  side = "right",
  initial_width = 35,
  hide_statusline = false,
  update_interval = 1000,
  sections = {"diagnostics", "symbols", "git" },
  section_separator = {"", "-----", ""},
  symbols = {
    icon = "ƒ",
  },
  containers = {
    attach_shell = "/bin/sh", show_all = true, interval = 5000,
  },
  datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
  todos = { ignored_paths = { "~" } },
})

vim.api.nvim_set_keymap('n', '<leader>t', "<cmd>lua require'sidebar-nvim'.toggle()<cr>", {})
