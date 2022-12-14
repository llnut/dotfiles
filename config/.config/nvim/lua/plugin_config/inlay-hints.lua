vim.cmd([[:highlight inlayHint ctermfg=DarkGreen guifg=SeaGreen]])

local M = {
  enabled = nil,
  inlay_hints = setmetatable({ cache = {}, enabled = false }, { __index = M }),
  namespace = vim.api.nvim_create_namespace("textDocument/inlayHints"),
}

local config = {
  -- Only show inlay hints for the current line
  only_current_line = false,

  -- whether to show parameter hints with the inlay hints or not
  -- default: true
  show_parameter_hints = true,

  -- prefix for parameter hints
  -- default: "<-"
  parameter_hints_prefix = "<- ",

  -- prefix for all the other hints (type, chaining)
  -- default: "=>"
  other_hints_prefix = "=> ",

  -- whether to align to the lenght of the longest line in the file
  max_len_align = false,

  -- padding from the left if max_len_align is true
  max_len_align_padding = 1,

  -- whether to align to the extreme right or not
  right_align = false,

  -- padding from the right if right_align is true
  right_align_padding = 7,

  -- The color of the hints
  highlight = "inlayHint",
}

local function clear_ns(bufnr)
  -- clear namespace which clears the virtual text as well
  vim.api.nvim_buf_clear_namespace(bufnr, M.namespace, 0, -1)
end

-- Disable hints and clear all cached buffers
function M.disable()
  M.inlay_hints.disable = false
  M.disable_cache_autocmd()

  for k, _ in pairs(M.inlay_hints.cache) do
    if vim.api.nvim_buf_is_valid(k) then
      clear_ns(k)
    end
  end
end

local function set_all()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    M.cache_render(bufnr)
  end
end

-- Enable auto hints and set hints for the current buffer
function M.enable()
  M.enable_cache_autocmd()
  set_all()
end

-- Set inlay hints only for the current buffer
function M.set()
  M.cache_render(0)
end

-- Clear hints only for the current buffer
function M.unset()
  clear_ns(0)
end

function M.enable_cache_autocmd()
  local opts = config
  vim.cmd(string.format(
    [[
        augroup InlayHintsCache
        autocmd BufWritePost,BufReadPost,BufEnter,BufWinEnter,TabEnter,TextChanged,TextChangedI *.rs :lua require('plugin_config.inlay-hints').cache_render()
        %s
        augroup END
    ]],
    opts.only_current_line
    and "autocmd CursorMoved,CursorMovedI *.rs :lua require('plugin_config.inlay-hints').render()"
    or ""
  ))
end

function M.disable_cache_autocmd()
  vim.cmd(
    [[
    augroup InlayHintsCache
    autocmd!
    augroup END
  ]],
    false
  )
end

local function get_params(client, bufnr)
  local params = {
    textDocument = vim.lsp.util.make_text_document_params(bufnr),
    range = {
      start = {
        line = 0,
        character = 0,
      },
      ["end"] = {
        line = 0,
        character = 0,
      },
    },
  }

  local line_count = vim.api.nvim_buf_line_count(bufnr) - 1
  local last_line = vim.api.nvim_buf_get_lines(
    bufnr,
    line_count,
    line_count + 1,
    true
  )

  params["range"]["end"]["line"] = line_count
  params["range"]["end"]["character"] = vim.lsp.util.character_offset(
    bufnr,
    line_count,
    #last_line[1],
    client.offset_encoding
  )

  return params
end

-- parses the result into a easily parsable format
-- example:
-- {
--  ["12"] = { {
--      kind = "TypeHint",
--      label = "String"
--    } },
--  ["13"] = { {
--      kind = "TypeHint",
--      label = "usize"
--    } },
-- }
--
local function parse_hints(result)
  local map = {}

  if type(result) ~= "table" then
    return {}
  end
  for _, value in pairs(result) do
    local range = value.position
    local line = value.position.line
    local label = value.label
    local kind = value.kind

    local function add_line()
      if map[line] ~= nil then
        table.insert(map[line], { label = label, kind = kind, range = range })
      else
        map[line] = { { label = label, kind = kind, range = range } }
      end
    end

    add_line()
  end
  return map
end

function M.cache_render(bufnr)
  local buffer = bufnr or vim.api.nvim_get_current_buf()

  for _, v in ipairs(vim.lsp.buf_get_clients(buffer)) do
    if M.is_ra_server(v) then
      v.request(
        "textDocument/inlayHint",
        get_params(v, buffer),
        function(err, result, ctx)
          if err then
            return
          end

          if not vim.api.nvim_buf_is_valid(ctx.bufnr) then
            M.inlay_hints.cache[ctx.bufnr] = nil
            return
          end

          M.inlay_hints.cache[ctx.bufnr] = parse_hints(result)

          M.render(ctx.bufnr)
        end,
        buffer
      )
    end
  end
end

local function render_line(line, line_hints, bufnr)
  local opts = config
  local virt_text = ""

  local param_hints = {}
  local other_hints = {}

  if line > vim.api.nvim_buf_line_count(bufnr) then
    return
  end

  -- segregate parameter hints and other hints
  for _, hint in ipairs(line_hints) do
    if hint.kind == 2 then
      table.insert(param_hints, hint.label)
    end

    if hint.kind == 1 then
      table.insert(other_hints, hint)
    end
  end

  -- show parameter hints inside brackets with commas and a thin arrow
  if not vim.tbl_isempty(param_hints) and opts.show_parameter_hints then
    virt_text = virt_text .. opts.parameter_hints_prefix .. "("
    for i, p_hint in ipairs(param_hints) do
      virt_text = virt_text .. p_hint:sub(1, -2)
      if i ~= #param_hints then
        virt_text = virt_text .. ", "
      end
    end
    virt_text = virt_text .. ") "
  end

  -- show other hints with commas and a thicc arrow
  if not vim.tbl_isempty(other_hints) then
    virt_text = virt_text .. opts.other_hints_prefix
    for i, o_hint in ipairs(other_hints) do
      if string.sub(o_hint.label, 1, 2) == ": " then
        virt_text = virt_text .. o_hint.label:sub(3)
      else
        virt_text = virt_text .. o_hint.label
      end
      if i ~= #other_hints then
        virt_text = virt_text .. ", "
      end
    end
  end

  -- set the virtual text if it is not empty
  if virt_text ~= "" then
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.api.nvim_buf_set_extmark(bufnr, M.namespace, line, 0, {
      virt_text_pos = opts.right_align and "right_align" or "eol",
      virt_text = {
        { virt_text, opts.highlight },
      },
      hl_mode = "combine",
    })
  end
end

function M.render(bufnr)
  local opts = config
  local buffer = bufnr or vim.api.nvim_get_current_buf()

  local hints = M.inlay_hints.cache[buffer]

  if hints == nil then
    return
  end

  clear_ns(buffer)

  if opts.only_current_line then
    local curr_line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local line_hints = hints[curr_line]
    if line_hints then
      render_line(curr_line, line_hints, buffer)
    end
  else
    for line, line_hints in pairs(hints) do
      render_line(line, line_hints, buffer)
    end
  end
end

function M.is_ra_server(client)
  local name = client.name
  return client.name == "rust_analyzer"
    or client.name == "rust_analyzer-standalone"
end

function M.toggle_inlay_hints()
  if M.enabled then
    M.disable()
  else
    M.enable()
  end
  M.enabled = not M.enabled
  print(M.enabled)
end

return M
