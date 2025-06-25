vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    end
    if client:supports_method('textDocument/diagnostic') then
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    end
    if client:supports_method('textDocument/declaration') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    end
    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
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
      vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
    end
    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action, opts)
    end
    if client:supports_method('textDocument/references') then
      vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
    end
    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, opts)
    end
    if client:supports_method('textDocument/signatureHelp') then
      vim.keymap.set('n', '<C-S>', vim.lsp.buf.signature_help, opts)
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
            features = { "vm" }
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
