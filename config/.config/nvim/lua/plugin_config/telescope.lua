require('telescope').setup{
  defaults = {
    layout_config = {
      horizontal = {
        height = 0.8,
        width = 0.9
      }
    },
    border = true,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      --"--hidden"
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
}

require("telescope").load_extension("ui-select")
