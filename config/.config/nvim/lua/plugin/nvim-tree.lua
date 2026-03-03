-- Official documentation: https://github.com/nvim-tree/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = true,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = {
    "NvimTreeOpen",
    "NvimTreeClose",
    "NvimTreeToggle",
    "NvimTreeFindFile",
    "NvimTreeFindFileToggle",
  },
  keys = {
    { "<leader>d", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    { "<leader>f", "<cmd>NvimTreeFindFile<CR>", desc = "Find file in NvimTree" },
  },
  init = function()
    -- Disable netrw at the very start of init.lua (recommended)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
      icons = {
        show = {
          git = true,
          folder = true,
          file = true,
          folder_arrow = true,
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = { "^.git$" },
    },
    git = {
      enable = true,
      ignore = false,
    },
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- Custom mappings
      vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    end,
  },
}
