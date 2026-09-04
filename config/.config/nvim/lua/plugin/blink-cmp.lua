-- Official documentation: https://cmp.saghen.dev
return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' preset plus Enter to accept and Tab/S-Tab to move in the list
    keymap = {
      preset = 'default',
      ['<CR>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        'fallback',
      },
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<C-e>'] = { 'hide' },
    },

    -- Window borders follow 'winborder'
    completion = {
      menu = {
        draw = {
          columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
    },

    signature = { enabled = true },

    -- crates.nvim provides Cargo.toml completions through its LSP mode
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { 'sources.default' },
}
