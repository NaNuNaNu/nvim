local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "clangd", "gopls", "pyright", "sqls" }

for _, lsp in ipairs(servers) do
  if lsp == "clangd" then
    lspconfig[lsp].setup {
      cmd = { "clangd", "--compile-commands-dir=build", "--background-index" },
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git")
    }
  elseif lsp == "gopls" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
      init_options = {
        buildFlags = { "-tags=integration" },
      },
    }
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
    }
  end
end
