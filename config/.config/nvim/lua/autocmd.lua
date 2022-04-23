vim.api.nvim_create_augroup("AutoUpdatePlugins", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", { pattern = "plugins.lua", command = "source <afile> | PackerSync", group = 'AutoUpdatePlugins' })

vim.api.nvim_create_augroup("Highlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", { command = "silent! lua vim.highlight.on_yank() {higroup='IncSearch', timeout=400}", group = 'Highlight' })

vim.api.nvim_create_autocmd("TextYankPost", { command = "silent! lua vim.highlight.on_yank() {higroup='IncSearch', timeout=400}", group = 'Highlight' })

vim.api.nvim_create_augroup("BufFile", { clear = true })

--- Treat .json files as .js
vim.api.nvim_create_autocmd("BufRead", 
{ 
  group = 'BufFile',
  pattern = "*.json",
  command = "setfiletype json syntax=javascript",
})

-- Treat .md files as Markdown
vim.api.nvim_create_autocmd("BufRead", 
{
  group = 'BufFile',
  pattern = "*.md",
  command = "setlocal filetype=markdown",
})

-- Get the 2-space YAML,yml,lua as the default when hit carriage return after the colon
vim.api.nvim_create_autocmd("FileType", 
{
  group = 'BufFile',
  pattern = "yaml\\|yml\\|lua",
  command = "setlocal ts=2 sts=2 sw=2 expandtab",
})

-- Trim trailing white space on save
-- vim.api.nvim_create_autocmd("BufWritePre", 
-- {
--     group = 'BufFile',
--     pattern = "*",
--     command = "lua require('function').strip_white_space()",
-- })

-- Toggle between current and the last accessed tab
vim.api.nvim_create_autocmd("TabLeave", 
{
  pattern = "*",
  command = "let g:lasttab = tabpagenr()",
})

-- Return to last edit position when opening files (You want this!)
vim.api.nvim_create_autocmd("BufReadPost", 
{
  group = 'BufFile',
  pattern = "*",
  command = "lua require('function').return_last_pos()",
})
