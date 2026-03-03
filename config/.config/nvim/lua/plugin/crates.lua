-- Official documentation: https://github.com/saecki/crates.nvim
return {
  'saecki/crates.nvim',
  tag = 'stable',
  event = { "BufRead Cargo.toml" },
  dependencies = { 'saghen/blink.cmp' },
  opts = {
    completion = {
      crates = {
        enabled = true,
      },
    },
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
    popup = {
      autofocus = true,
      hide_on_select = false,
      copy_register = '"',
      style = "minimal",
      border = "rounded",
      show_version_date = true,
      show_dependency_version = true,
      max_height = 30,
      min_width = 20,
      padding = 1,
    },
  },
}
