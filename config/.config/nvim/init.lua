-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.updatetime = 500

--custom plugin
require("run_file").setup({ keymap = "<leader>r" })

-- Autosave on CursorHold and CursorHoldI events
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  pattern = "*", -- Apply to all files
  command = "silent! write", -- Save the file silently
})
