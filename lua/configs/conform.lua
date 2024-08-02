local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "python" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    objc = { "clang_format" },
    objcpp = { "clang_format" },
    cuda = { "clang_format" },
    proto = { "clang_format" },
    ["*"] = { "codespell" },
    ["_"] = { "trim_whitespace"},
  },

  format_on_save = {
  --   -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
