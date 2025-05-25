return {
  "crnvl96/lazydocker.nvim",
  lazy = true,
  cmd = { "LazyDocker" }, -- This might need adjustment based on actual commands
  dependencies = {
    "MunifTanjim/nui.nvim", -- Keep this if it's actually needed
  },
  opts = {
    window = {
      settings = {
        width = 0.9, -- 90% of screen width
        height = 0.9, -- 90% of screen height
        border = "rounded",
        relative = "editor",
      },
    },
  },
  keys = {
    {
      "<C-c>",
      function()
        require("lazydocker").toggle()
      end,
      desc = "Toggle LazyDocker",
    },
    -- Alternatively, if the global is available:
    -- { "<C-c>", "<cmd>lua LazyDocker.toggle()<CR>", desc = "Toggle LazyDocker" },
  },
}
