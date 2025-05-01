-- This file now returns the 'opts' table directly for rustaceanvim v4

-- Get NvChad/LazyVim capabilities
local capabilities = require("nvchad.configs.lspconfig").capabilities -- Make sure this path is correct for NvyChad

local opts = {
  -- LSP Server settings (managed by rustaceanvim)
  server = {
    on_attach = function(client, bufnr)
      -- You can retain your custom keymaps or use rustaceanvim defaults
      vim.keymap.set("n", "<leader>ca", function() vim.cmd.RustLsp("codeAction") end, { desc = "Code Action", buffer = bufnr }) -- Changed key slightly
      vim.keymap.set("n", "<leader>dR", function() vim.cmd.RustLsp("debuggables") end, { desc = "Rust Debuggables", buffer = bufnr }) -- Changed key slightly

      -- Example: Add standard LSP keymaps if not set globally
      -- vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
      -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP Go to Definition" })
      -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP Go to References" })
    end,
    capabilities = capabilities,
    settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true, -- Changed from buildScripts.enable for consistency
        },
        checkOnSave = {
           command = "clippy", -- Or "check", explicit clippy might be better for prod grade
           -- Add extraArgs if needed: extraArgs = {"--", "-A", "clippy::some-lint"}
        },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
         -- Optional: Enable inlay hints via rust-analyzer (rustaceanvim might have its own way too)
         inlayHints = {
           bindingModeHints = { enable = true },
           chainingHints = { enable = true },
           closingBraceHints = { enable = true, minLines = 5},
           lifetimeElisionHints = { enable = true, useParameterNames = true },
           maxLength = 15,
           parameterHints = { enable = true },
           reborrowHints = { enable = true },
           renderColons = true,
           typeHints = { enable = true, hideLeastSpecific = true },
         },
        -- Exclude directories (Your existing list looks fine)
        files = {
          excludeDirs = { ".direnv", ".git", ".github", ".gitlab", "bin", "node_modules", "target", "venv", ".venv"},
        },
      },
    },
  },

  -- DAP configuration integrated with rustaceanvim
  dap = {
    adapter = { -- Adapter config precedence: explicit cmd > mason > native extension
      type = "executable", -- Use executable type
      command = "codelldb", -- Command name Mason installs
      name = "rt_codelldb", -- Adapter name within nvim-dap
        -- Ensure Mason provides codelldb. If you installed manually, provide the full path:
        -- command = "/path/to/your/codelldb",
    },
    -- Add configurations for launching/attaching. Rustaceanvim might generate some defaults.
    -- You can add specific launch configurations here if needed, similar to the nvim-dap setup:
    -- configurations = {
    --   {
    --      name = "Launch file (rustaceanvim)",
    --      type = "rt_codelldb", -- MUST match the adapter name above
    --      request = "launch",
    --      program = function()
    --        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    --      end,
    --      cwd = "${workspaceFolder}",
    --      stopOnEntry = false,
    --      sourceLanguages = { "rust" },
    --   }
    -- },
  },

  -- Optional: Configure rustaceanvim specific features like tools, inlay hints etc.
  -- tools = { ... },
  -- inlay_hints = { enabled = true, ... } -- if you prefer rustaceanvim's hints over rust-analyzer's direct ones
}

return opts
