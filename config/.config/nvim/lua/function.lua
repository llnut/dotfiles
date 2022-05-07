-- Custom Folds, make them look better
vim.cmd([[
function! CustomFold()
return printf('   %-6d%s', v:foldend - v:foldstart + 1, getline(v:foldstart))
endfunction
]])

-- It manages folds automatically based on treesitter
local parsers = require'nvim-treesitter.parsers'
local configs = parsers.get_parser_configs()
local ft_str = table.concat(vim.tbl_map(function(ft) return configs[ft].filetype or ft end, parsers.available_parsers()), ',')
vim.cmd('autocmd Filetype ' .. ft_str .. ' setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()')

-- Exported functions
local M = {}

M.align = function()
  local p = '^\\s*|\\s.*\\s|\\s*$'
  if vim.fn.exists(':Tabularize') and vim.fn.getline('.') == "~# '^\\s*|'" and (vim.fn.getline(vim.fn.line('.') - 1) == "~# " .. p or vim.fn.getline(vim.fn.line('.')+1 == "~# " .. p)) then
    -- local column = vim.fn.strlen(vim.fn.substitute(vim.fn.getline('.')[0:vim.fn.col('.')], '[^|]','','g'))
    -- local position = vim.fn.strlen(vim.fn.matchstr(vim.fn.getline('.')[0:vim.fn.col('.')], '.*|\s*\zs.*'))
    vim.cmd([[
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    ]])
  end
end

M.v_set_search = function()
  vim.cmd([[
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
  ]])
end

M.return_last_pos = function()
  --print(vim.fn.line("'\""))
  --command = "if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe \"normal! g'\\\"\" | endif",
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
  elseif vim.fn.expand('%:t') == 'Cargo.toml' then
    require('crates').show_popup()
  else
    vim.lsp.buf.hover()
  end
end

-- callback args changed in Neovim 0.5.1/0.6. See:
-- https://github.com/neovim/neovim/pull/15504
M.mk_handler = function(fn)
  return function(...)
    local config_or_client_id = select(4, ...)
    local is_new = type(config_or_client_id) ~= "number"
    if is_new then
      fn(...)
    else
      local err = select(1, ...)
      local method = select(2, ...)
      local result = select(3, ...)
      local client_id = select(4, ...)
      local bufnr = select(5, ...)
      local config = select(6, ...)
      fn(
        err,
        result,
        { method = method, client_id = client_id, bufnr = bufnr },
        config
      )
    end
  end
end

-- from mfussenegger/nvim-lsp-compl@29a81f3
M.request = function(bufnr, method, params, handler)
  return vim.lsp.buf_request(bufnr, method, params, M.mk_handler(handler))
end

local function get_params()
  local params = vim.lsp.util.make_given_range_params()
  params["range"]["start"]["line"] = 0
  params["range"]["end"]["line"] = vim.api.nvim_buf_line_count(0) - 1
  return params
end


return M
