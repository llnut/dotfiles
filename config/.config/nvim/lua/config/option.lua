local home_dir = os.getenv("HOME")

local options = {
  clipboard      = vim.env.SSH_TTY and "" or "unnamed,unnamedplus",
  cmdheight      = 1,
  completeopt    = "menu,menuone,noselect",
  cursorline     = true,
  expandtab      = true,
  fillchars      = { fold = ' ', eob = ' ' },
  foldlevelstart = 99,
  ignorecase     = true,
  laststatus     = 3,
  mouse          = "a",
  number         = true,
  pumheight      = 15,
  relativenumber = true,
  scrolloff      = 8,
  shiftwidth     = 4,
  showtabline    = 2,
  signcolumn     = "yes",
  smartcase      = true,
  smartindent    = true,
  softtabstop    = 4,
  splitbelow     = true,
  splitright     = true,
  swapfile       = false,
  tabstop        = 4,
  termguicolors  = true,
  timeoutlen     = 300,
  undodir        = home_dir .. "/.config/nvim/undo",
  undofile       = true,
  updatetime     = 250,
  shada          = "'1000",
  wildignore     = { "*.o", "*~", "*.pyc", "*node_modules/**", "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.DS_Store", "*/target/*" },
  wrap           = true,
  linebreak      = true,
  writebackup    = false,
  backup         = false,
  conceallevel   = 0,
  fileencoding   = "utf-8",
  incsearch      = true,
  hlsearch       = true,
  showmode       = false,
  showmatch      = true,
  foldcolumn     = "1",
  fileformats    = "unix,dos,mac",
  list           = true,
  listchars      = "tab:▸ ,trail:·,nbsp:_,extends:›,precedes:‹",
  title          = true,
  showcmd        = true,
  splitkeep      = "screen",
  modeline       = false,
  modelines      = 0,
}

local globals = {
  snacks_animate    = false,
  python3_host_prog = '/usr/bin/python',
  lasttab           = 1,
}

vim.opt.shortmess:append('c');
vim.opt.formatoptions:remove('c');
vim.opt.formatoptions:remove('r');
vim.opt.formatoptions:remove('o');

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end

if vim.env.TMUX then
  vim.cmd([[
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  ]])
end
