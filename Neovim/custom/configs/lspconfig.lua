local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")

-- LSP for python
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})

-- LSP for go 
lspconfig.gopls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {"go"},
}


-- LSP for C, C++
lspconfig.clangd.setup({
  on_attach = function (client, bufnr)
    client.server_capabilites.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  -- filetypes = {"python"},
})

