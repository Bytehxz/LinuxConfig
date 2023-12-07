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
  settings = {
    gopls = {
      analyses = {
        assign = true,
        atomic = true,
        bools = true,
        composites = true,
        copylocks = true,
        deepequalerrors = true,
        embed = true,
        errorsas = true,
        fieldalignment = true,
        httpresponse = true,
        ifaceassert = true,
        loopclosure = true,
        lostcancel = true,
        nilfunc = true,
        nilness = true,
        nonewvars = true,
        printf = true,
        shadow = true,
        shift = true,
        simplifycompositelit = true,
        simplifyrange = true,
        simplifyslice = true,
        sortslice = true,
        stdmethods = true,
        stringintconv = true,
        structtag = true,
        testinggoroutine = true,
        tests = true,
        timeformat = true,
        unmarshal = true,
        unreachable = true,
        unsafeptr = true,
        unusedparams = true,
        unusedresult = true,
        unusedvariable = true,
        unusedwrite = true,
        useany = true,
      },
      hoverKind = "FullDocumentation",
      linkTarget = "pkg.go.dev",
      usePlaceholders = true,
      vulncheck = "Imports",
    },
  },
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

