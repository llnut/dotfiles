-- Highlight ColorColumn ctermbg=magenta
vim.cmd([[
" Enable syntax highlighting
syntax enable

colorscheme gruvbox
]])
vim.o.background = "dark"
--
---- Set extra options when running in GUI mode
--if vim.fn.has("gui_running") then
--  vim.opt.guitablabel="%M\\ %t"
--end
