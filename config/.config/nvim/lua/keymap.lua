local keymap = vim.api.nvim_set_keymap;

-- save file
keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = false })

-- Save a file as root (,W)
keymap("n", "<leader>W", ":w suda://%<CR>", { noremap = true, silent = false })

--------------------------------------------------------------
-- => Tabular
--------------------------------------------------------------
keymap("i", "<Bar>", "<Bar><Esc>:<CMD>lua require('function').align()<CR>a", { noremap = true, silent = true })

--------------------------------------------------------------
-- => Visual mode related
--------------------------------------------------------------
-- Visual star search
keymap("x", "*", ": <C-u><CMD>lua require('function').v_set_search() <CR>/<C-R>=@/<CR><CR>", { noremap = true, silent = false })
keymap("x", "#", ": <C-u><CMD>lua require('function').v_set_search() <CR>?<C-R>=@/<CR><CR>", { noremap = true, silent = false })

--------------------------------------------------------------
-- => Moving around, tabs, windows and buffers
--------------------------------------------------------------
keymap("", "<C-h>", "<C-w>h", { noremap = true, silent = false })
keymap("", "<C-j>", "<C-w>j", { noremap = true, silent = false })
keymap("", "<C-k>", "<C-w>k", { noremap = true, silent = false })
keymap("", "<C-l>", "<C-w>l", { noremap = true, silent = false })

-- no highlighting temporary with <leader>ht
keymap("", "<leader>ht", ":nohlsearch<CR>", { noremap = true, silent = true })

-- Close the current window.
keymap("n", "<leader>cw", ":close<CR>", { noremap = true, silent = false })

-- Close current tab
keymap("n", "<leader>ct", ":tabclose<CR>", { noremap = true, silent = false })
-- New tab
keymap("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = false })
-- Close Location panel
keymap("n", "<leader>ce", ":lclose<CR>", { noremap = true, silent = false })
-- Switch buffers
keymap("n", "[b", ":BufferPrevious<CR>", { noremap = true, silent = true })
keymap("n", "]b", ":BufferNext<CR>", { noremap = true, silent = true })
keymap("n", "[B", ":BufferGoto 1<CR>", { noremap = true, silent = true })
keymap("n", "]B", ":BufferLast<CR>", { noremap = true, silent = true })

-- Buffers
keymap("n", "<Tab>", ":BufferNext<CR>", { noremap = true, silent = true })
keymap("n", "<S-Tab>", ":BufferPrevious<CR>", { noremap = true, silent = true })
keymap("n", "<S-q>", ":BufferClose<CR>", { noremap = true, silent = true })
keymap("n", "<leader>q", ":BufferClose<cr>", { noremap = true, silent = false })
--keymap("n", "<leader>q", "<CMD>lua require('function').buf_close_it()<CR>", { noremap = true, silent = false })
keymap("n", "<leader>Q", ":%bdelete<cr>", { noremap = true, silent = false })

--Goto buffer in position...
keymap("n", "<A-1>", ":BufferGoto 1<CR>", { noremap = true, silent = true })
keymap("n", "<A-2>", ":BufferGoto 2<CR>", { noremap = true, silent = true })
keymap("n", "<A-3>", ":BufferGoto 3<CR>", { noremap = true, silent = true })
keymap("n", "<A-4>", ":BufferGoto 4<CR>", { noremap = true, silent = true })
keymap("n", "<A-5>", ":BufferGoto 5<CR>", { noremap = true, silent = true })
keymap("n", "<A-6>", ":BufferGoto 6<CR>", { noremap = true, silent = true })
keymap("n", "<A-7>", ":BufferGoto 7<CR>", { noremap = true, silent = true })
keymap("n", "<A-8>", ":BufferGoto 8<CR>", { noremap = true, silent = true })
keymap("n", "<A-9>", ":BufferGoto 9<CR>", { noremap = true, silent = true })

--Pin/unpin buffer
keymap("n", "<A-p>", ":BufferPin<CR>", { noremap = true, silent = true })

--Switch tabs
keymap("n", "[t", ":tabprevious<CR>", { noremap = true, silent = true })
keymap("n", "]t", ":tabprevious<CR>", { noremap = true, silent = true })
keymap("n", "[T", ":tabfirst<CR>", { noremap = true, silent = true })
keymap("n", "]T", ":tablast<CR>", { noremap = true, silent = true })
--copen
keymap("n", "<leader>co", ":copen<CR>", { noremap = true, silent = false })

-- Let 'tl' toggle between this and the last accessed tab
keymap("n", "<leader>tl", ":exe \"tabn \".g:lasttab<CR>", { noremap = false, silent = false })

-- cd to the directory containing the file in the buffer
keymap("", "<leader>cd", ":lcd %:h<CR>:pwd<cr>", { noremap = true, silent = false })

-- Strip trailing whitespace (,ss)
keymap("", "<leader>ss", "<CMD>lua require('function').strip_white_space()<CR>", { noremap = true, silent = false })

-- Quickly open a buffer for scribble
keymap("", "<leader>z", ":e ~/buffer<cr>", { noremap = false, silent = false })

-- Quickly open a markdown buffer for scribble
keymap("", "<leader>x", ":e ~/buffer.md<cr>", { noremap = false, silent = false })

-- Quickly open README.md
keymap("", "<leader>c", ":e ~/README.md<cr>", { noremap = false, silent = false })

keymap("", "<C-p>", "<cmd>lua require('telescope.builtin').find_files({hidden=false})<CR>", { noremap = false, silent = false })
keymap("", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<CR>", { noremap = false, silent = false })
keymap("", "<leader>tg", "<cmd>lua require('telescope.builtin').treesitter()<CR>", { noremap = false, silent = false })
keymap("", "<leader>m", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", { noremap = false, silent = false })
keymap("", "<leader>rg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true, silent = false })
keymap("", "<leader>eg", "<cmd>lua require('telescope.builtin').live_grep({prompt_title = 'find in open buffers', grep_open_files = true})<CR>", { noremap = true, silent = false })

keymap("", "<leader>d", ":NvimTreeToggle<CR>", { noremap = true, silent = false })
keymap("", "<leader>ff", ":NvimTreeFindFile<CR>", { noremap = true, silent = false })

-- keymap("", "<bs>", ":tabprevious<CR>", { noremap = true, silent = false })
-- keymap("", "<C-l>", ":tabnext<CR>", { noremap = true, silent = false })
-- keymap("i", "[", "[]<esc>i", { noremap = true, silent = false })
-- keymap("i", "{", "{}<esc>i", { noremap = true, silent = false })
-- keymap("i", "{<CR>", "{<CR>}<c-o>O", { noremap = true, silent = false })
-- keymap("i", "(", "()<esc>i", { noremap = true, silent = false })
-- keymap("i", "<>", "<><<esc>i", { noremap = true, silent = false })
-- keymap("i", "\"", "\"\"<esc>i", { noremap = true, silent = false })
-- keymap("i", "'", "''<esc>i", { noremap = true, silent = false })

-- set text wrapping toggles
keymap("", "<leader>tw", ":set invwrap<CR>:set wrap?<CR>", { noremap = true, silent = true })
keymap("", "<leader>l", ": Tab/", { noremap = true, silent = false })

keymap("", "]c", "<cmd>Gitsigns next_hunk<CR>", { noremap = true, silent = false })
keymap("", "[c", "<cmd>Gitsigns prev_hunk<CR>", { noremap = true, silent = false })

-- Down is really the next line
-- keymap("n", "j", "gj", { noremap = true, silent = false })
-- keymap("n", "k", "gk", { noremap = true, silent = false })

-- Resize vsplit
keymap("n", "25s", ":vertical resize 40<cr>", { noremap = false, silent = false })
keymap("n", "50s", "<c-w>=", { noremap = false, silent = false })
keymap("n", "75s", ":vertical resize 120<cr>", { noremap = false, silent = false })
keymap("n", "<leader>>", ":exe \"vertical resize \" . (winwidth(0) * 3/2)<CR>", { noremap = true, silent = true })
keymap("n", "<leader><", ":exe \"vertical resize \" . (winwidth(0) * 2/3)<CR>", { noremap = true, silent = true })
keymap("n", "<leader>+", ":exe \"resize \" . (winheight(0) * 3/2)<CR>", { noremap = true, silent = true })
keymap("n", "<leader>-", ":exe \"resize \" . (winheight(0) * 2/3)<CR>", { noremap = true, silent = true })

-- Undotree
keymap("n", "<leader>u", ":UndotreeToggle<cr>", { noremap = true, silent = false })

-- com Wdt windo diffthis
-- com Wdo diffoff!
keymap("n", "<leader>scb", ":windo set scrollbind!<CR>", { noremap = true, silent = true })
keymap("n", "<C-6>", "<C-^>", { noremap = true, silent = false })

-- Select the last changed text(or the text that was just pasted)
keymap("n", "gp", "`[v`]", { noremap = true, silent = false })

keymap("n", "<leader><leader>df", "<CMD>lua require('function').diff_with_saved()<CR>", { noremap = true, silent = false })
keymap("n", "<leader><leader>fn", "<CMD>lua require('function').quick_fix_file_names()<CR>", { noremap = true, silent = false })

keymap("n", "<leader>em", ":Himalaya<CR>", { noremap = false, silent = false })

-- type inlay hints
keymap("", "<leader>ty", "<cmd>lua require('plugin_config.inlay-hints').toggle_inlay_hints()<CR>", { noremap = true, silent = false })
