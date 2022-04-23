-- Highlight ColorColumn ctermbg=magenta
vim.cmd([[
" Enable syntax highlighting
syntax enable

colorscheme gruvbox
]])
vim.g.gruvbox_contrast_light = 'hard'
vim.g.gruvbox_contrast_dark = 'soft'
vim.opt.background = "dark"
--
---- Set extra options when running in GUI mode
if vim.fn.has("gui_running") then
  vim.opt.guitablabel="%M\\ %t"
end
