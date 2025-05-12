vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    ---- Unmap rename
    --vim.keymap.del('n', 'grn', opts)

    ---- Unmap code_action
    --vim.keymap.del('n', 'gra', opts)

    ---- Unmap references
    --vim.keymap.del('n', 'grr', opts)

    ---- Unmap implementation
    --vim.keymap.del('n', 'gri', opts)

    ---- Unmap document_symbol
    --vim.keymap.del('n', 'gO', opts)

    ---- Unmap signature_help
    --vim.keymap.del('n', '<C-S>', opts)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    --if client:supports_method('textDocument/implementation') then
    --  -- Create a keymap for vim.lsp.buf.implementation
    --end
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    end
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
      and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        --group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
    if client:supports_method('textDocument/diagnostic') then
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    end
    --if client:supports_method('window/showDocument') then
    --  vim.keymap.set('n', 'K', vim.lsp.showDocument, opts)
    --end
    if client:supports_method('textDocument/declaration') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    end
    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    end
    if client:supports_method('textDocument/hover') then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    end
    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    end
    if client:supports_method('textDocument/signatureHelp') then
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    end
    if client:supports_method('workspace/workspaceFolders') then
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
    end
    if client:supports_method('textDocument/typeDefinition*') then
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    end
    if client:supports_method('textDocument/rename') then
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    end
    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    end
    if client:supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end
    if client:supports_method('textDocument/formatting') then
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = nil,
      source = 'always',
      prefix = nil,
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})


vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  float = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250

return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "mason.nvim",
    "saghen/blink.cmp",
  },
  config = function(_, opts)
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local lspconfig = require('lspconfig')
    local servers = { "clangd", "asm_lsp" }
    for _, lsp in pairs(servers) do
      lspconfig[lsp].setup({ capabilities = capabilities })
    end

    lspconfig.rust_analyzer.setup({
      -- Server-specific settings. See `:help lspconfig-setup`
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            -- allFeatures = true
            -- features = {}
          }
        }
      },
      capabilities = capabilities
    })

    --lspconfig.harper_ls.setup {
    --  settings = {
    --    ["harper-ls"] = {
    --      --userDictPath = "~/dict.txt",
    --      diagnosticSeverity = "hint",
    --    }
    --  },
    --}
  end,
}
