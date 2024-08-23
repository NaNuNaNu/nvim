-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "clangd", "gopls", "pyright", "zls", "sqls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

local cap = vim.lsp.protocol.make_client_capabilities()
lspconfig["pyright"].capabilities = require('cmp_nvim_lsp').default_capabilities(cap)
lspconfig["clangd"].capabilities = require("cmp_nvim_lsp").default_capabilities(cap)


