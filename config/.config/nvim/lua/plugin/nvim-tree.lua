-- Official documentation: :h nvim-tree-quickstart-setup
-- netrw is disabled through lazy.nvim's disabled_plugins list.
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
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
  ---@type nvim_tree.config
  opts = {
    sort = {
      sorter = "case_sensitive",
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      custom = { "^.git$" },
    },
    git = {
      ignore = false,
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buf = bufnr, nowait = true }
      end

      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- Custom mappings
      vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    end,
  },
}
