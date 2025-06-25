local keymap = vim.keymap.set
local option = { noremap = true, silent = true }

-- save file
keymap("n", "<leader>w", ":w<CR>", option)

--------------------------------------------------------------
-- => Moving around, tabs, windows and buffers
--------------------------------------------------------------
keymap("", "<C-h>", "<C-w>h", option)
keymap("", "<C-j>", "<C-w>j", option)
keymap("", "<C-k>", "<C-w>k", option)
keymap("", "<C-l>", "<C-w>l", option)

-- no highlighting temporary with <leader>ht
keymap("", "<leader>ht", ":nohlsearch<CR>", option)

-- Close the current window.
keymap("n", "<leader>cw", ":close<CR>", option)
-- Close Location panel
keymap("n", "<leader>ce", ":lclose<CR>", option)
-- Switch buffers
keymap("n", "[b", ":bprevious<CR>", option)
keymap("n", "]b", ":bnext<CR>", option)
keymap("n", "[B", ":bfirst 1<CR>", option)
keymap("n", "]B", ":blast<CR>", option)

-- Buffers
--keymap("n", "<leader>q", ":Bclose<cr>", option)
keymap("n", "<leader>q", ":lua require('util.function').buf_close_it()<CR>", option)
keymap("n", "<leader>Q", ":%bdelete<cr>", option)

-- New tab
keymap("n", "<leader>tn", ":tabnew<CR>", option)
--Switch tabs
keymap("n", "[t", ":tabprevious<CR>", option)
keymap("n", "]t", ":tabnext<CR>", option)
keymap("n", "[T", ":tabfirst<CR>", option)
keymap("n", "]T", ":tablast<CR>", option)
-- Close current tab
keymap("n", "<leader>tq", ":tabclose<CR>", option)
keymap("n", "<leader>tQ", ":tabonly<CR>", option)
--copen
keymap("n", "<leader>co", ":copen<CR>", option)

-- cd to the directory containing the file in the buffer
keymap("", "<leader>cd", ":lcd %:h<CR>:pwd<cr>", option)

-- Strip trailing whitespace (,ss)
keymap("", "<leader>ss", ":lua require('util.function').strip_white_space()<CR>", option)

-- Quickly open file
keymap("", "<leader>z", ":e ~/buffer<cr>", option)
keymap("", "<leader>x", ":e ~/buffer.md<cr>", option)
keymap("", "<leader>c", ":e ~/README.md<cr>", option)

keymap("", "<leader>d", ":NvimTreeToggle<CR>", option)
keymap("", "<leader>f", ":NvimTreeFindFile<CR>", option)

-- keymap("", "<bs>", ":tabprevious<CR>", option)
-- keymap("", "<C-l>", ":tabnext<CR>", option)
-- keymap("i", "[", "[]<esc>i", option)
-- keymap("i", "{", "{}<esc>i", option)
-- keymap("i", "{<CR>", "{<CR>}<c-o>O", option)
-- keymap("i", "(", "()<esc>i", option)
-- keymap("i", "<>", "<><<esc>i", option)
-- keymap("i", "\"", "\"\"<esc>i", option)
-- keymap("i", "'", "''<esc>i", option)

-- set text wrapping toggles
keymap("", "<leader>tw", ":set invwrap<CR>:set wrap?<CR>", option)

keymap("", "]c", ":Gitsigns next_hunk<CR>", option)
keymap("", "[c", ":Gitsigns prev_hunk<CR>", option)

-- Down is really the next line
-- keymap("n", "j", "gj", option)
-- keymap("n", "k", "gk", option)

-- Resize vsplit
keymap("n", "25s", ":vertical resize 40<cr>", option)
keymap("n", "50s", "<c-w>=", option)
keymap("n", "75s", ":vertical resize 120<cr>", option)
keymap("n", "<leader>>", ":exe \"vertical resize \" . (winwidth(0) * 3/2)<CR>", option)
keymap("n", "<leader><", ":exe \"vertical resize \" . (winwidth(0) * 2/3)<CR>", option)
keymap("n", "<leader>+", ":exe \"resize \" . (winheight(0) * 3/2)<CR>", option)
keymap("n", "<leader>-", ":exe \"resize \" . (winheight(0) * 2/3)<CR>", option)

keymap("n", "<leader>scb", ":windo set scrollbind!<CR>", option)
keymap("n", "<C-6>", "<C-^>", option)

-- Select the last changed text(or the text that was just pasted)
keymap("n", "gp", "`[v`]", option)

keymap("n", "<leader><leader>df", ":lua require('util.function').diff_with_saved()<CR>", option)
keymap("n", "<leader><leader>fn", ":lua require('util.function').quick_fix_file_names()<CR>", option)

-- inlay hint
keymap("", "<leader>ih", ":lua require('util.function').toggle_inlay_hint()<CR>", option)
-- lsp toggle
keymap("", "<leader>tl", ":lua require('util.function').toggle_lsp_client()<CR>", option)

-- default show_documentation
keymap("n", "K", ":lua require('util.function').show_documentation()<CR>", option)

-- format current buf
keymap("n", "<Space>f", ":lua require('util.function').buf_format()<CR>", option)
