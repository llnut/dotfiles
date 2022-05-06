require('telescope').setup{
  defaults = {
    layout_config = {
      horizontal = {
        height = 0.8,
        width = 0.9
      }
    },
    border = false,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden"
    }
  }
}
