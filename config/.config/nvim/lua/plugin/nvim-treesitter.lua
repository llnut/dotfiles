-- Official documentation: https://github.com/nvim-treesitter/nvim-treesitter
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

-- Treesitter indentation is experimental and weak for these languages
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
  -- The rewritten main branch; the old master branch is frozen
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- No-op for parsers that are already installed
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
      desc = "Enable treesitter for every filetype with an installed parser",
      callback = function(args)
        if is_large_file(args.buf) then
          return
        end

        local lang = vim.treesitter.language.get_lang(args.match) or args.match

        -- Some runtime ftplugins already start the highlighter
        if not vim.treesitter.highlighter.active[args.buf] then
          if not pcall(vim.treesitter.start, args.buf, lang) then
            return
          end
        end

        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"

        if not indent_disabled[lang] then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
