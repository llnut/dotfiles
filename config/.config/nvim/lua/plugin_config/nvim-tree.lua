local Api = require "nvim-tree.api"

local list = {
  {
    key = { "<CR>", "o", "<2-LeftMouse>" },
    callback = Api.node.open.edit,
    desc = "open a file or folder; root will cd to the above directory",
  },
  {
    key = "<C-e>",
    callback = Api.node.open.replace_tree_buffer,
    desc = "edit the file in place, effectively replacing the tree explorer",
  },
  {
    key = "O",
    callback = Api.node.open.no_window_picker,
    desc = "same as (edit) with no window picker",
  },
  {
    key = { "<C-]>", "<2-RightMouse>" },
    callback = Api.tree.change_root_to_node,
    desc = "cd in the directory under the cursor",
  },
  {
    key = "<C-v>",
    callback = Api.node.open.vertical,
    desc = "open the file in a vertical split",
  },
  {
    key = "<C-x>",
    callback = Api.node.open.horizontal,
    desc = "open the file in a horizontal split",
  },
  {
    key = "<C-t>",
    callback = Api.node.open.tab,
    desc = "open the file in a new tab",
  },
  {
    key = "<",
    callback = Api.node.navigate.sibling.prev,
    desc = "navigate to the previous sibling of current file/directory",
  },
  {
    key = ">",
    callback = Api.node.navigate.sibling.next,
    desc = "navigate to the next sibling of current file/directory",
  },
  {
    key = "P",
    callback = Api.node.navigate.parent,
    desc = "move cursor to the parent directory",
  },
  {
    key = "<BS>",
    callback = Api.node.navigate.parent_close,
    desc = "close current opened directory or parent",
  },
  {
    key = "<Tab>",
    callback = Api.node.open.preview,
    desc = "open the file as a preview (keeps the cursor in the tree)",
  },
  {
    key = "K",
    callback = Api.node.navigate.sibling.first,
    desc = "navigate to the first sibling of current file/directory",
  },
  {
    key = "J",
    callback = Api.node.navigate.sibling.last,
    desc = "navigate to the last sibling of current file/directory",
  },
  {
    key = "I",
    callback = Api.tree.toggle_gitignore_filter,
    desc = "toggle visibility of files/folders hidden via |git.ignore| option",
  },
  {
    key = "H",
    callback = Api.tree.toggle_hidden_filter,
    desc = "toggle visibility of dotfiles via |filters.dotfiles| option",
  },
  {
    key = "U",
    callback = Api.tree.toggle_custom_filter,
    desc = "toggle visibility of files/folders hidden via |filters.custom| option",
  },
  {
    key = "R",
    callback = Api.tree.reload,
    desc = "refresh the tree",
  },
  {
    key = "a",
    callback = Api.fs.create,
    desc = "add a file; leaving a trailing `/` will add a directory",
  },
  {
    key = "d",
    callback = Api.fs.remove,
    desc = "delete a file (will prompt for confirmation)",
  },
  {
    key = "D",
    callback = Api.fs.trash,
    desc = "trash a file via |trash| option",
  },
  {
    key = "r",
    callback = Api.fs.rename,
    desc = "rename a file",
  },
  {
    key = "<C-r>",
    callback = Api.fs.rename_sub,
    desc = "rename a file and omit the filename on input",
  },
  {
    key = "x",
    callback = Api.fs.cut,
    desc = "add/remove file/directory to cut clipboard",
  },
  {
    key = "c",
    callback = Api.fs.copy.node,
    desc = "add/remove file/directory to copy clipboard",
  },
  {
    key = "p",
    callback = Api.fs.paste,
    desc = "paste from clipboard; cut clipboard has precedence over copy; will prompt for confirmation",
  },
  {
    key = "y",
    callback = Api.fs.copy.filename,
    desc = "copy name to system clipboard",
  },
  {
    key = "Y",
    callback = Api.fs.copy.relative_path,
    desc = "copy relative path to system clipboard",
  },
  {
    key = "gy",
    callback = Api.fs.copy.absolute_path,
    desc = "copy absolute path to system clipboard",
  },
  {
    key = "]e",
    callback = Api.node.navigate.diagnostics.next,
    desc = "go to next diagnostic item",
  },
  {
    key = "]c",
    callback = Api.node.navigate.git.next,
    desc = "go to next git item",
  },
  {
    key = "[e",
    callback = Api.node.navigate.diagnostics.prev,
    desc = "go to prev diagnostic item",
  },
  {
    key = "[c",
    callback = Api.node.navigate.git.prev,
    desc = "go to prev git item",
  },
  {
    key = "-",
    callback = Api.tree.change_root_to_parent,
    desc = "navigate up to the parent directory of the current file/directory",
  },
  {
    key = "s",
    callback = Api.node.run.system,
    desc = "open a file with default system application or a folder with default file manager, using |system_open| option",
  },
  {
    key = "f",
    callback = Api.live_filter.start,
    desc = "live filter nodes dynamically based on regex matching.",
  },
  {
    key = "F",
    callback = Api.live_filter.clear,
    desc = "clear live filter",
  },
  {
    key = "q",
    callback = Api.tree.close,
    desc = "close tree window",
  },
  {
    key = "W",
    callback = Api.tree.collapse_all,
    desc = "collapse the whole tree",
  },
  {
    key = "E",
    callback = Api.tree.expand_all,
    desc = "expand the whole tree, stopping after expanding |callbacks.expand_all.max_folder_discovery| folders; this might hang neovim for a while if running on a big folder",
  },
  {
    key = "S",
    callback = Api.tree.search_node,
    desc = "prompt the user to enter a path and then expands the tree to match the path",
  },
  {
    key = ".",
    callback = Api.node.run.cmd,
    desc = "enter vim command mode with the file the cursor is on",
  },
  {
    key = "<C-k>",
    callback = Api.node.show_info_popup,
    desc = "toggle a popup with file infos about the file under the cursor",
  },
  {
    key = "g?",
    callback = Api.tree.toggle_help,
    desc = "toggle help",
  },
  {
    key = "m",
    callback = Api.marks.toggle,
    desc = "Toggle node in bookmarks",
  },
  {
    key = "bmv",
    callback = Api.marks.bulk.move,
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
  focus_empty_on_setup = false,
  ignore_buf_on_tab_change = {},
  sort_by = "name",
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  on_attach = "disable",
  remove_keymaps = false,
  select_prompts = false,
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
    float = {
      enable = false,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_width = 2,
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
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
    enable = true,
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
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
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

