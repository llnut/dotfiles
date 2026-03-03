local M = {}

M.return_last_pos = function()
  local mark = vim.api.nvim_buf_get_mark(0, '"')
  local line_count = vim.api.nvim_buf_line_count(0)
  if mark[1] > 0 and mark[1] <= line_count then
    vim.api.nvim_win_set_cursor(0, mark)
  end
end

M.buf_close_it = function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  
  if #buffers <= 1 then
    vim.cmd('enew')
  else
    local alternate_buf = vim.fn.bufnr('#')
    if alternate_buf ~= -1 and vim.fn.buflisted(alternate_buf) == 1 then
      vim.cmd('buffer #')
    else
      vim.cmd('bnext')
    end
  end
  
  if vim.api.nvim_buf_is_valid(current_buf) and vim.fn.buflisted(current_buf) == 1 then
    vim.cmd('bdelete! ' .. current_buf)
  end
end

M.strip_white_space = function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local search_reg = vim.fn.getreg('/')
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.fn.setreg('/', search_reg)
  pcall(vim.api.nvim_win_set_cursor, 0, cursor_pos)
end

M.diff_with_saved = function()
  local ft = vim.bo.filetype
  vim.cmd([[
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
  ]])
  vim.cmd('setlocal bt=nofile bh=wipe nobl noswf ro ft=' .. ft)
end

M.show_documentation = function()
  local ft = vim.bo.filetype
  if vim.tbl_contains({ 'vim', 'help' }, ft) then
    vim.cmd.help(vim.fn.expand('<cword>'))
  elseif vim.tbl_contains({ 'man' }, ft) then
    vim.cmd.Man(vim.fn.expand('<cword>'))
  elseif vim.fn.expand('%:t') == 'Cargo.toml' then
    local ok, crates = pcall(require, 'crates')
    if ok and crates.popup_available() then
      crates.show_popup()
    else
      vim.lsp.buf.hover()
    end
  else
    vim.lsp.buf.hover()
  end
end

M.toggle_inlay_hint = function()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end

M.toggle_lsp_client = function()
  local buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf })
  if #clients > 0 then
    for _, client in ipairs(clients) do
      vim.lsp.stop_client(client.id)
    end
  else
    vim.cmd.edit()
  end
end

M.buf_format = function()
  vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
end

M.quick_fix_file_names = function()
  local qflist = vim.fn.getqflist()
  local files = {}
  for _, item in ipairs(qflist) do
    if item.bufnr ~= 0 then
      local fname = vim.api.nvim_buf_get_name(item.bufnr)
      if fname ~= '' and not files[fname] then
        files[fname] = true
        print(fname)
      end
    end
  end
end

return M



