local home_dir = os.getenv("HOME")

local options = {
  clipboard      = "unnamed,unnamedplus",   --- Copy-paste between vim and everything else
  cmdheight      = 1,                       --- Give more space for displaying messages
  completeopt    = "menu,menuone,noselect", --- Better autocompletion
  cursorline     = true,                    --- Highlight of current line
  emoji          = false,                   --- Fix emoji display
  expandtab      = true,                    --- Use spaces instead of tabs
  foldlevelstart = 99,                      --- Expand all folds by default
  ignorecase     = true,                    --- Needed for smartcase
  laststatus     = 3,                       --- Have a global statusline at the bottom instead of one for each window
  lazyredraw     = true,                    --- Makes macros faster & prevent errors in complicated mappings
  mouse          = "a",                     --- Enable mouse
  number         = true,                    --- Shows current line number
  pumheight      = 10,                      --- Max num of items in completion menu
  relativenumber = true,                    --- Enables relative number
  scrolloff      = 3,                       --- Always keep space when scrolling to bottom/top edge
  shiftwidth     = 4,                       --- Change a number of space characeters inseted for indentation
  showtabline    = 2,                       --- Always show tabs
  signcolumn     = "yes",                   --- Add extra sign column next to line number
  smartcase      = true,                    --- Uses case in search
  smartindent    = true,                    --- Makes indenting smart
  smarttab       = true,                    --- Makes tabbing smarter will realize you have 2 vs 4
  softtabstop    = 4,                       --- Insert 4 spaces for a tab
  splitright     = true,                    --- Vertical splits will automatically be to the right
  swapfile       = false,                   --- Swap not needed
  tabstop        = 4,                       --- Insert 4 spaces for a tab
  termguicolors  = true,                    --- Correct terminal colors
  timeoutlen     = 500,                     --- Faster completion
  undodir        = home_dir .. "/.config/nvim/undo",
  undofile       = true,                    --- Sets undo to file
  updatetime     = 500,                     --- Faster completion
  shada          = "'1000",                 --- Increase the size of file history
  wrap           = true,                    --- Wrap long lines
  si             = true,
  linebreak      = true,                    --- Will wrap lone lines at a character in 'breakat'
  textwidth      = 500,                     --- Maximum width of text that is being inserted
  writebackup    = false,                   --- Not needed
  -- Neovim defaults
  autoindent     = true,                    --- Good auto indent
  backspace      = "indent,eol,start",      --- Making sure backspace works
  backup         = false,                   --- Recommended by coc
  backupskip     = "/tmp/*,/private/tmp/*",
  backupdir      = home_dir .. "/.config/nvim/backups",
  directory      = home_dir .. "/.config/nvim/swaps",
  conceallevel   = 0,                       --- Show `` in markdown files
  encoding       = "utf-8",                 --- The encoding displayed
  errorbells     = false,                   --- Disables sound effect for errors
  fileencoding   = "utf-8",                 --- The encoding written to file
  incsearch      = true,                    --- Start searching before pressing enter
  hlsearch       = true,                    --- Highlight searches
  showmode       = true,                    --- Show the current mode
  hidden         = true,                    --- A buffer becomes hidden when it is abandoned
  ruler          = false,                    --- Show the cursor position
  magic          = true,                    --- For regular expressions turn magic on
  showmatch      = true,                    --- Show matching brackets when text indicator is over them
  mat            = 2,                       --- How many tenths of a second to blink when matching brackets
  foldcolumn     = "1",                     --- Add a bit extra margin to the left
  fileformats    = "unix,dos,mac",          --- Use Unix as the standard file type
  autoread       = false,                    --- Set to auto read when a file is changed from the outside
  wildmenu       = true,                    --- Enhance command-line completion
  gdefault       = false,                    --- Add the g flag to search/replace by default
  endofline      = false,                   --- Don’t add empty newlines at the end of files

  modeline       = true,                    --- Respect modeline in files
  modelines      = 4,

  exrc           = true,                    --- Enable per-directory .vimrc files and disable unsafe commands in them
  secure         = true,

  lcs            = [[tab:▸\ ,trail:·,nbsp:_]], --- Show “invisible” characters
  list           = true,

  title          = true,                    --- Show the filename in the window titlebar
  showcmd        = true,                    --- Show the (partial) command as it’s being typed
  completeopt    = "menu,menuone,noselect",
}

local globals = {
  fillchars                   = "fold:\\ ", --- Fill chars needed for folds
  mapleader                   = ',',        --- Map leader key to SPC
  speeddating_no_mappings     = 1,          --- Disable default mappings for speeddating
  python3_host_prog           = '/usr/bin/python',
  history                     = 500,        --- Sets how many lines of history VIM has to remember
  wildignore     = "*.o,*~,*.pyc,*node_modules/**,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store",      --- Ignore compiled files
  lasttab        = 1,                       --- Toggle between current and the last accessed tab
  -- switchbuf      = "useopen,usetab,newtab",
  -- stal           = 2,
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

vim.cmd([[
" Enable filetype plugins
filetype plugin on
filetype indent on
filetype on

" If you use vim inside tmux, see https://github.com/vim/vim/issues/993
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
]])
