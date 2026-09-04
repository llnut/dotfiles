-- Filetype specific settings live in after/ftplugin/.
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup('GeneralSettings', { clear = true })

autocmd('TextYankPost', {
  group = general,
  desc = 'Highlight when yanking text',
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

autocmd('BufReadPost', {
  group = general,
  desc = 'Return to last edit position',
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
