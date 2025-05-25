return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    require("dap-go").setup()
    require("dap-python").setup("python3")
    require("dapui").setup()
    vim.keymap.set("n", "<leader>dtb", function()
      dap.toggle_breakpoint()
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>dc", function()
      require("dap").continue()
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>du", function()
      dapui.close()
    end, { noremap = true, silent = true })
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
