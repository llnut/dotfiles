-- Official documentation: https://github.com/saecki/crates.nvim
return {
  'saecki/crates.nvim',
  tag = 'stable',
  event = { "BufRead Cargo.toml" },
  opts = {
    -- In-process language server: completion, hover and code actions reach
    -- blink.cmp and the LSP keymaps without extra sources
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
    popup = {
      autofocus = true,
      border = "rounded",
      show_version_date = true,
    },
  },
}
