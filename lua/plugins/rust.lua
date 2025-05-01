return {
  -- Core Rust experience via rustaceanvim
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = { "rust" },
    dependencies = {
       "neovim/nvim-lspconfig",
       "mfussenegger/nvim-dap",
    },
  },

  -- Dependency management for Cargo.toml
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" }, -- Ensure plenary is listed if not global
    opts = {
      completion = { crates = { enabled = true } },
      lsp = { enabled = true, actions = true, completion = true, hover = true },
      popup = { border = "rounded" }, -- Optional: Style popup
    },
    config = function(_, opts)
      require("crates").setup(opts)
    end,
  },

  -- Testing framework
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "rouge8/neotest-rust", -- Rust adapter
      "mfussenegger/nvim-dap",     -- Needed for debugging tests
    },
    opts = {
      adapters = {
        ["neotest-rust"] = {},
      },
    },
    config = function(_, opts)
      require("neotest").setup(opts)

      -- Add keymaps for testing here or in your main keymap file
      vim.keymap.set("n", "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Test: Run File" })
      vim.keymap.set("n", "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, { desc = "Test: Run All Tests" })
      vim.keymap.set("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Test: Run Nearest" })
      vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Test: Toggle Summary" })
      vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end, { desc = "Test: Show Output" })
      vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, { desc = "Test: Debug Nearest" })

    end,
  },

  -- Ensure debug adapter is installed via Mason
   {
     "williamboman/mason.nvim",
     opts = function(_, opts)
       opts.ensure_installed = opts.ensure_installed or {}
       -- Add codelldb. rust-analyzer might be handled by rustaceanvim itself.
       -- Remove rustfmt/clippy as they should be installed via rustup.
       vim.list_extend(opts.ensure_installed, {
         "codelldb",
       })
     end,
   }
}
