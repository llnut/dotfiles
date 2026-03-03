-- Official documentation: https://github.com/nvim-treesitter/nvim-treesitter
-- IMPORTANT: Requires Neovim 0.11.0+
return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- Use main branch for latest
  lazy = false,    -- Don't lazy load as per official docs
  build = ':TSUpdate',
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "gnn", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },
  opts = {
    ensure_installed = {
      "c",
      "lua",
      "rust",
      "bash",
      "python",
      "toml",
      "json",
      "yaml",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "regex",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
      enable = true,
      -- Disable for large files
      disable = function(lang, buf)
        local max_filesize = 200 * 1024 -- 200 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      -- Set to false for no additional vim regex highlighting
      additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "<bs>",
      },
    },

    -- Indentation based on treesitter (experimental)
    indent = {
      enable = true,
      disable = { "python", "yaml" },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    -- Enable folding with treesitter
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
}
