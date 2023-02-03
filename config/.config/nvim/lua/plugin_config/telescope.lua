require('telescope').setup{
  defaults = {
    layout_config = {
      horizontal = {
        height = 0.75,
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
      require("telescope.themes").get_dropdown {}
    }
  }
}

require("telescope").load_extension("ui-select")
