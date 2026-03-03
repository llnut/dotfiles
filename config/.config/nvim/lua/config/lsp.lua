local M = {}

local function setup_keymaps(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  local set = vim.keymap.set

  -- Diagnostic float (default is <C-W>d, keep <space>e for familiarity)
  set('n', '<space>e', vim.diagnostic.open_float, opts)
  -- Diagnostic loclist (no Neovim default)
  set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Signature help in NORMAL mode (0.11 default is insert/select mode only)
  if client:supports_method('textDocument/signatureHelp') then
    set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
  end

  -- Format (no Neovim default keymap)
  if client:supports_method('textDocument/formatting') then
    set('n', '<space>f', function()
      vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
    end, opts)
  end

  -- Workspace folders (no Neovim defaults)
  if client:supports_method('workspace/workspaceFolders') then
    set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
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
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  -- Auto-show diagnostics on cursor hold
  vim.api.nvim_create_autocmd('CursorHold', {
    group = vim.api.nvim_create_augroup('LspDiagnosticFloat', { clear = true }),
    callback = function()
      if vim.fn.mode() == 'n' then
        vim.diagnostic.open_float(nil, {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        })
      end
    end,
  })

  -- Global LSP capabilities
  vim.lsp.config('*', {
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true,
            resolveSupport = {
              properties = { 'documentation', 'detail', 'additionalTextEdits' }
            }
          }
        }
      }
    }
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
end

return M
