local plugins = {
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require "configs.rust"
    end
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    'saecki/crates.nvim',
    ft = { "toml" },
    config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      require('cmp').setup.buffer({
        sources = { { name = "crates" } }
      })
      crates.show()
    end,
  },
}

return plugins
