local M = {}

M.return_last_pos = function()
  if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
    vim.cmd("normal! g'\"")
  end
end

M.buf_close_it = function()
  local current_buf = vim.fn.bufnr("%")
  local alternate_buf = vim.fn.bufnr("#")

  if vim.fn.buflisted(alternate_buf) == true then
    vim.cmd('buffer #')
  else
    vim.cmd('bnext')
  end

  if vim.fn.buflisted(current_buf) then
    vim.cmd("bdelete! " .. current_buf)
  end
end

M.strip_white_space = function()
  local save_cursor = vim.fn.getpos(".")
  local old_query = vim.fn.getreg("/")
  vim.cmd([[:%s/\(\s\+\|\)$//e]])
  vim.fn.setpos(".", save_cursor)
  vim.fn.setreg("/", old_cursor)
end

-- Diff current buffer and the original file
M.diff_with_saved = function()
  local filetype = vim.api.nvim_eval("&ft")
  vim.cmd([[
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  ]])
  vim.cmd("setlocal bt=nofile bh=wipe nobl noswf ro ft=" .. filetype)
end

M.show_documentation = function()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ 'vim','help' }, filetype) then
    vim.cmd('h '..vim.fn.expand('<cword>'))
  elseif vim.tbl_contains({ 'man' }, filetype) then
    vim.cmd('Man '..vim.fn.expand('<cword>'))
  elseif vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
    require('crates').show_popup()
  else
    vim.lsp.buf.hover()
  end
end

function M.toggle_inlay_hint()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
end

function M.toggle_lsp_client()
  local buf = vim.api.nvim_get_current_buf()

  local clients = vim.lsp.get_clients({ bufnr = buf })
  if not vim.tbl_isempty(clients) then
    vim.cmd("LspStop")
  else
    vim.cmd("LspStart")
  end
end

return M

