-- Official documentation: https://github.com/akinsho/bufferline.nvim
return {
  'akinsho/bufferline.nvim',
  version = "*",
  event = "VeryLazy",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
    { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
  },
  opts = {
    options = {
      mode = "buffers",
      themable = true,
      numbers = "none",
      close_command = function(n)
        Snacks.bufdelete(n)
      end,
      right_mouse_command = function(n)
        Snacks.bufdelete(n)
      end,
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,
      indicator = {
        icon = '▎',
        style = 'icon',
      },
      buffer_close_icon = '󰅖',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 18,
      max_prefix_length = 15,
      truncate_names = true,
      tab_size = 18,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "(" .. count .. ")"
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true,
          highlight = "Directory",
        },
        {
          filetype = "snacks_layout_box",
        },
      },
      color_icons = true,
      get_element_icon = function(element)
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
        return icon, hl
      end,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true,
      duplicates_across_groups = true,
      persist_buffer_sort = true,
      move_wraps_at_ends = false,
      separator_style = "slant",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 150,
        reveal = { 'close' },
      },
      sort_by = 'insert_at_end',
    },
  },
}
