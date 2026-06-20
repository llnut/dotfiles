local parsers = {
  "bash",
  "c",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "rust",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
}

local filetypes = {
  "bash",
  "c",
  "help",
  "json",
  "lua",
  "markdown",
  "python",
  "query",
  "regex",
  "rust",
  "sh",
  "toml",
  "vim",
  "yaml",
}

local filetype_to_lang = {
  help = "vimdoc",
  sh = "bash",
}

local indent_disabled = {
  python = true,
  yaml = true,
}

local function is_large_file(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return false
  end

  local ok, stats = pcall(vim.uv.fs_stat, name)
  return ok and stats and stats.size > 200 * 1024
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  version = false,
  lazy = false,
  build = function()
    local treesitter = require("nvim-treesitter")
    treesitter.install(parsers):wait(300000)
    treesitter.update(parsers):wait(300000)
  end,
  cmd = { "TSInstall", "TSInstallFromGrammar", "TSLog", "TSUninstall", "TSUpdate" },
  config = function()
    vim.opt.foldlevelstart = 99

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
      pattern = filetypes,
      callback = function(args)
        if is_large_file(args.buf) then
          return
        end

        local ft = vim.bo[args.buf].filetype
        local lang = filetype_to_lang[ft] or vim.treesitter.language.get_lang(ft) or ft
        local ok = pcall(vim.treesitter.start, args.buf, lang)
        if not ok then
          return
        end

        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldlevel = 99

        if not indent_disabled[lang] then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
