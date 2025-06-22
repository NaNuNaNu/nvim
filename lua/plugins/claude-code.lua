return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  keys = {
    { "<leader>cc", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code" },
  },
  cmd = "ClaudeCode",
  config = function()
    -- This is where you customize the plugin
    require("claude-code").setup({
      window = {
        position = "vertical", -- "botright", "topleft", etc.
        split_ratio = 0.4,    -- Use 40% of the screen width for the vertical split
      }
      -- You can add any other valid options here
    })
  end
}
