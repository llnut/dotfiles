-- Official documentation: https://cmp.saghen.dev/configuration/reference
return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- Keymap presets: 'default' | 'super-tab' | 'enter' | 'none'
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
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },

      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = 'rounded',
          draw = {
            columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = 'rounded',
          },
        },
        ghost_text = {
          enabled = false,
        },
      },

      signature = {
        enabled = true,
        window = {
          border = 'rounded',
        },
      },

      -- crates.nvim virtual LSP provides Cargo.toml completions via the lsp source
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = {
        frecency = {
          enabled = true,
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
