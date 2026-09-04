local options = {
  clipboard      = vim.env.SSH_TTY and "" or "unnamed,unnamedplus",
  completeopt    = "menu,menuone,noselect",
  cursorline     = true,
  expandtab      = true,
  fileencoding   = "utf-8",
  fileformats    = "unix,dos,mac",
  fillchars      = { fold = ' ', eob = ' ' },
  foldcolumn     = "1",
  foldlevelstart = 99,
  ignorecase     = true,
  laststatus     = 3,
  linebreak      = true,
  list           = true,
  listchars      = "tab:▸ ,trail:·,nbsp:_,extends:›,precedes:‹",
  modeline       = false,
  modelines      = 0,
  mouse          = "a",
  number         = true,
  pumheight      = 15,
  relativenumber = true,
  scrolloff      = 8,
  shada          = "'1000",
  shiftwidth     = 4,
  showmatch      = true,
  showmode       = false,
  showtabline    = 2,
  signcolumn     = "yes",
  smartcase      = true,
  smartindent    = true,
  softtabstop    = 4,
  splitbelow     = true,
  splitkeep      = "screen",
  splitright     = true,
  swapfile       = false,
  tabstop        = 4,
  termguicolors  = true,
  timeoutlen     = 300,
  title          = true,
  undofile       = true,
  updatetime     = 250,
  wildignore     = { "*.o", "*~", "*.pyc", "*node_modules/**", "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.DS_Store", "*/target/*" },
  winborder      = "rounded",
  writebackup    = false,
}

-- Remote plugin providers are not used
local globals = {
  loaded_node_provider    = 0,
  loaded_perl_provider    = 0,
  loaded_python3_provider = 0,
  loaded_ruby_provider    = 0,
}

vim.opt.shortmess:append('c')
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end
