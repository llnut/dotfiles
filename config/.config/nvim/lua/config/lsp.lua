local M = {}

local servers = { 'asm_lsp', 'clangd', 'lua_ls', 'rust_analyzer' }

local function setup_keymaps(client, bufnr)
  local function map(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { buf = bufnr, desc = desc })
  end

  -- Diagnostic float (default is <C-W>d, keep <space>e for familiarity)
  map('<space>e', vim.diagnostic.open_float, 'Diagnostic float')
  -- Diagnostic loclist (no Neovim default)
  map('<space>q', vim.diagnostic.setloclist, 'Diagnostics to location list')

  -- Signature help in Normal mode (the default <C-S> covers Insert mode only)
  if client:supports_method('textDocument/signatureHelp') then
    map('<C-s>', vim.lsp.buf.signature_help, 'Signature help')
  end

  -- Format (no Neovim default keymap)
  if client:supports_method('textDocument/formatting') then
    map('<space>f', function()
      vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
    end, 'Format buffer')
  end

  -- Workspace folders (no Neovim defaults)
  if client:supports_method('workspace/workspaceFolders') then
    map('<space>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder')
    map('<space>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
    map('<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'List workspace folders')
  end

  -- Inlay hints
  if client:supports_method('textDocument/inlayHint') then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

M.setup = function()
  vim.diagnostic.config({
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      },
    },
    float = {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      source = true,
      prefix = ' ',
      scope = 'cursor',
    },
    severity_sort = true,
  })

  -- Show the diagnostics under the cursor after 'updatetime' in Normal mode.
  -- The float takes its settings from vim.diagnostic.config().
  vim.api.nvim_create_autocmd('CursorHold', {
    group = vim.api.nvim_create_augroup('LspDiagnosticFloat', { clear = true }),
    callback = function()
      if vim.fn.mode() == 'n' then
        vim.diagnostic.open_float()
      end
    end,
  })

  -- Advertise the completion capabilities of blink.cmp to every server
  vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspKeymaps', { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        setup_keymaps(client, args.buf)
      end
    end,
  })

  vim.lsp.enable(servers)
end

return M
