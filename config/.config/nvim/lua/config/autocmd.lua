local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup('GeneralSettings', { clear = true })
local filetype_settings = augroup('FiletypeSettings', { clear = true })

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
  callback = function()
    require('util.function').return_last_pos()
  end,
})

autocmd('TabLeave', {
  group = general,
  desc = 'Track last tab for quick switching',
  callback = function()
    vim.g.lasttab = vim.fn.tabpagenr()
  end,
})

autocmd('FileType', {
  group = filetype_settings,
  pattern = { 'text', 'markdown', 'tex' },
  desc = 'Enable spell check',
  callback = function()
    vim.opt_local.spell = true
  end,
})

autocmd('FileType', {
  group = filetype_settings,
  pattern = { 'yaml', 'lua', 'html' },
  desc = 'Set 2-space indentation',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

autocmd('FileType', {
  group = filetype_settings,
  pattern = 'c',
  desc = 'Set 8-space tab for C',
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.softtabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.expandtab = false
  end,
})

