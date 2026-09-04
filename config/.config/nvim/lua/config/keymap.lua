local map = vim.keymap.set
local util = require('util.function')

local function scale_width(ratio)
  vim.api.nvim_win_set_width(0, math.floor(vim.api.nvim_win_get_width(0) * ratio))
end

local function scale_height(ratio)
  vim.api.nvim_win_set_height(0, math.floor(vim.api.nvim_win_get_height(0) * ratio))
end

-- save file
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })

--------------------------------------------------------------
-- => Moving around, tabs, windows and buffers
--------------------------------------------------------------
map('', '<C-h>', '<C-w>h', { desc = 'Window left' })
map('', '<C-j>', '<C-w>j', { desc = 'Window down' })
map('', '<C-k>', '<C-w>k', { desc = 'Window up' })
map('', '<C-l>', '<C-w>l', { desc = 'Window right' })

-- no highlighting temporary with <leader>ht
map('', '<leader>ht', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Close the current window.
map('n', '<leader>cw', '<cmd>close<CR>', { desc = 'Close window' })
-- Close Location panel
map('n', '<leader>ce', '<cmd>lclose<CR>', { desc = 'Close location list' })

-- Buffers ([b ]b [B ]B come from the bufferline spec)
map('n', '<leader>q', util.buf_close_it, { desc = 'Close buffer' })
map('n', '<leader>Q', '<cmd>%bdelete<CR>', { desc = 'Close all buffers' })

-- New tab
map('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'New tab' })
-- Switch tabs
map('n', '[t', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })
map('n', ']t', '<cmd>tabnext<CR>', { desc = 'Next tab' })
map('n', '[T', '<cmd>tabfirst<CR>', { desc = 'First tab' })
map('n', ']T', '<cmd>tablast<CR>', { desc = 'Last tab' })
-- Close current tab
map('n', '<leader>tq', '<cmd>tabclose<CR>', { desc = 'Close tab' })
map('n', '<leader>tQ', '<cmd>tabonly<CR>', { desc = 'Close other tabs' })
-- copen
map('n', '<leader>co', '<cmd>copen<CR>', { desc = 'Open quickfix list' })

-- cd to the directory containing the file in the buffer
map('', '<leader>cd', '<cmd>lcd %:h<CR><cmd>pwd<CR>', { desc = 'cd to file directory' })

-- Strip trailing whitespace
map('', '<leader>rw', util.strip_white_space, { desc = 'Strip trailing whitespace' })

-- Quickly open file
map('', '<leader>z', '<cmd>e ~/buffer<CR>', { desc = 'Open ~/buffer' })
map('', '<leader>x', '<cmd>e ~/buffer.md<CR>', { desc = 'Open ~/buffer.md' })
map('', '<leader>c', '<cmd>e ~/README.md<CR>', { desc = 'Open ~/README.md' })

-- set text wrapping toggles
map('', '<leader>tw', '<cmd>set invwrap<CR><cmd>set wrap?<CR>', { desc = 'Toggle wrap' })

-- Resize vsplit
map('n', '25s', '<cmd>vertical resize 40<CR>', { desc = 'Window width 40' })
map('n', '50s', '<C-w>=', { desc = 'Equalize windows' })
map('n', '75s', '<cmd>vertical resize 120<CR>', { desc = 'Window width 120' })
map('n', '<leader>>', function() scale_width(3 / 2) end, { desc = 'Widen window' })
map('n', '<leader><', function() scale_width(2 / 3) end, { desc = 'Narrow window' })
map('n', '<leader>+', function() scale_height(3 / 2) end, { desc = 'Grow window' })
map('n', '<leader>-', function() scale_height(2 / 3) end, { desc = 'Shrink window' })

map('n', '<leader>scb', '<cmd>windo set scrollbind!<CR>', { desc = 'Toggle scrollbind' })
map('n', '<C-6>', '<C-^>', { desc = 'Alternate buffer' })

-- Select the last changed text (or the text that was just pasted)
map('n', 'gp', '`[v`]', { desc = 'Select last changed text' })

map('n', '<leader><leader>df', util.diff_with_saved, { desc = 'Diff with saved file' })
map('n', '<leader><leader>fn', util.quick_fix_file_names, { desc = 'Print quickfix file names' })

-- inlay hint
map('', '<leader>ih', util.toggle_inlay_hint, { desc = 'Toggle inlay hints' })
-- lsp toggle
map('', '<leader>tl', util.toggle_lsp_client, { desc = 'Toggle LSP clients' })

-- A global K mapping takes precedence over the LSP default. This handler
-- routes help, man and Cargo.toml buffers to their own viewers and falls
-- back to vim.lsp.buf.hover() elsewhere.
map('n', 'K', util.show_documentation, { desc = 'Show documentation' })

-- format current buf
map('n', '<Space>f', util.buf_format, { desc = 'Format buffer' })
