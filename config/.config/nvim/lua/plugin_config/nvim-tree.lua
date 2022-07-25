local list = {
  {
    key = { "<CR>", "o", "<2-LeftMouse>" },
    action = "edit",
    desc = "open a file or folder; root will cd to the above directory",
  },
  {
    key = "<C-e>",
    action = "edit_in_place",
    desc = "edit the file in place, effectively replacing the tree explorer",
  },
  {
    key = "O",
    action = "edit_no_picker",
    desc = "same as (edit) with no window picker",
  },
  {
    key = { "<C-]>", "<2-RightMouse>" },
    action = "cd",
    desc = "cd in the directory under the cursor",
  },
  {
    key = "<C-v>",
    action = "vsplit",
    desc = "open the file in a vertical split",
  },
  {
    key = "<C-x>",
    action = "split",
    desc = "open the file in a horizontal split",
  },
  {
    key = "<C-t>",
    action = "tabnew",
    desc = "open the file in a new tab",
  },
  {
    key = "<",
    action = "prev_sibling",
    desc = "navigate to the previous sibling of current file/directory",
  },
  {
    key = ">",
    action = "next_sibling",
    desc = "navigate to the next sibling of current file/directory",
  },
  {
    key = "P",
    action = "parent_node",
    desc = "move cursor to the parent directory",
  },
  {
    key = "<BS>",
    action = "close_node",
    desc = "close current opened directory or parent",
  },
  {
    key = "<Tab>",
    action = "preview",
    desc = "open the file as a preview (keeps the cursor in the tree)",
  },
  {
    key = "K",
    action = "first_sibling",
    desc = "navigate to the first sibling of current file/directory",
  },
  {
    key = "J",
    action = "last_sibling",
    desc = "navigate to the last sibling of current file/directory",
  },
  {
    key = "I",
    action = "toggle_git_ignored",
    desc = "toggle visibility of files/folders hidden via |git.ignore| option",
  },
  {
    key = "H",
    action = "toggle_dotfiles",
    desc = "toggle visibility of dotfiles via |filters.dotfiles| option",
  },
  {
    key = "U",
    action = "toggle_custom",
    desc = "toggle visibility of files/folders hidden via |filters.custom| option",
  },
  {
    key = "R",
    action = "refresh",
    desc = "refresh the tree",
  },
  {
    key = "a",
    action = "create",
    desc = "add a file; leaving a trailing `/` will add a directory",
  },
  {
    key = "d",
    action = "remove",
    desc = "delete a file (will prompt for confirmation)",
  },
  {
    key = "D",
    action = "trash",
    desc = "trash a file via |trash| option",
  },
  {
    key = "r",
    action = "rename",
    desc = "rename a file",
  },
  {
    key = "<C-r>",
    action = "full_rename",
    desc = "rename a file and omit the filename on input",
  },
  {
    key = "x",
    action = "cut",
    desc = "add/remove file/directory to cut clipboard",
  },
  {
    key = "c",
    action = "copy",
    desc = "add/remove file/directory to copy clipboard",
  },
  {
    key = "p",
    action = "paste",
    desc = "paste from clipboard; cut clipboard has precedence over copy; will prompt for confirmation",
  },
  {
    key = "y",
    action = "copy_name",
    desc = "copy name to system clipboard",
  },
  {
    key = "Y",
    action = "copy_path",
    desc = "copy relative path to system clipboard",
  },
  {
    key = "gy",
    action = "copy_absolute_path",
    desc = "copy absolute path to system clipboard",
  },
  {
    key = "[e",
    action = "prev_diag_item",
    desc = "go to next diagnostic item",
  },
  {
    key = "[c",
    action = "prev_git_item",
    desc = "go to next git item",
  },
  {
    key = "]e",
    action = "next_diag_item",
    desc = "go to prev diagnostic item",
  },
  {
    key = "]c",
    action = "next_git_item",
    desc = "go to prev git item",
  },
  {
    key = "-",
    action = "dir_up",
    desc = "navigate up to the parent directory of the current file/directory",
  },
  {
    key = "s",
    action = "system_open",
    desc = "open a file with default system application or a folder with default file manager, using |system_open| option",
  },
  {
    key = "f",
    action = "live_filter",
    desc = "live filter nodes dynamically based on regex matching.",
  },
  {
    key = "F",
    action = "clear_live_filter",
    desc = "clear live filter",
  },
  {
    key = "q",
    action = "close",
    desc = "close tree window",
  },
  {
    key = "W",
    action = "collapse_all",
    desc = "collapse the whole tree",
  },
  {
    key = "E",
    action = "expand_all",
    desc = "expand the whole tree, stopping after expanding |actions.expand_all.max_folder_discovery| folders; this might hang neovim for a while if running on a big folder",
  },
  {
    key = "S",
    action = "search_node",
    desc = "prompt the user to enter a path and then expands the tree to match the path",
  },
  {
    key = ".",
    action = "run_file_command",
    desc = "enter vim command mode with the file the cursor is on",
  },
  {
    key = "<C-k>",
    action = "toggle_file_info",
    desc = "toggle a popup with file infos about the file under the cursor",
  },
  {
    key = "g?",
    action = "toggle_help",
    desc = "toggle help",
  },
  {
    key = "m",
    action = "toggle_mark",
    desc = "Toggle node in bookmarks",
  },
  {
    key = "bmv",
    action = "bulk_move",
    desc = "Move all bookmarked nodes into specified location",
  },
}

require'nvim-tree'.setup {
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = list,
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = false,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    symlink_destination = true,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_root = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  filesystem_watchers = {
    enable = false,
    debounce_delay = 50,
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "gio trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
}

