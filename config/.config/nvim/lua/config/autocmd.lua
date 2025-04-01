vim.api.nvim_create_autocmd(
  "TextYankPost",
  { callback = function() vim.hl.on_yank({ higroup = 'IncSearch', timeout = 100 }) end }
)

vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern = { "*.txt", "*.md", "*.tex" },
    command = "setlocal spell"
  }
)
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern = "*.json",
    command = "setfiletype json syntax=javascript",
  }
)

-- Treat .md files as Markdown
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern = "*.md",
    command = "setlocal filetype=markdown",
  }
)

-- Get the 2-space as the default when hit carriage return after the colon
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
    pattern = { "*.yaml", "*.yml", "*.lua", "*.cmake", "*.html", "*.md" },
    command = "setlocal ts=2 sts=2 sw=2 expandtab",
  }
)

-- Trim trailing white space on save
-- vim.api.nvim_create_autocmd("BufWritePre", 
-- {
--     group = 'BufFile',
--     pattern = "*",
--     command = "lua require('util.function').strip_white_space()",
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
  pattern = "*",
  command = "lua require('util.function').return_last_pos()",
})

