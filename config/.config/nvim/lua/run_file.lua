-- ~/.config/nvim/lua/run_file/init.lua

local M = {}

-- Table mapping filetypes to commands for running them
local run_commands = {
  python = "python3",
  javascript = "node",
  typescript = "ts-node",
  lua = "lua",
  ruby = "ruby",
  rust = "cargo run",
  go = "go run",
  sh = "bash",
  c = "gcc %s -o /tmp/c_output && /tmp/c_output",
  cpp = "g++ %s -o /tmp/cpp_output && /tmp/cpp_output",
  java = "javac %s && java %s",
  php = "php",
  perl = "perl"
}

-- Function to get the current file path
local function get_current_file()
  return vim.fn.expand('%:p')
end

-- Function to get the current file directory
local function get_current_dir()
  return vim.fn.expand('%:p:h')
end

-- Function to get filename without extension
local function get_filename_no_ext()
  return vim.fn.expand('%:t:r')
end

-- Function to run the current file
function M.run_file()
  local filetype = vim.bo.filetype
  local file = get_current_file()
  local cmd = run_commands[filetype]
 
  if not cmd then
    vim.notify("No run command found for filetype: " .. filetype, vim.log.levels.ERROR)
    return
  end
 
  -- Handle special cases
  if filetype == "java" then
    cmd = string.format(cmd, file, get_filename_no_ext())
  elseif filetype == "c" or filetype == "cpp" then
    cmd = string.format(cmd, file)
  else
    cmd = cmd .. " " .. file
  end
 
  -- Change directory to file location
  local dir = get_current_dir()
 
  -- Open a terminal in a split window
  vim.cmd("split")
  vim.cmd("terminal cd " .. vim.fn.shellescape(dir) .. " && " .. cmd)
 
  -- Go to insert mode to interact with the terminal
  vim.cmd("startinsert")
end

-- Set up key mapping
function M.setup(opts)
  opts = opts or {}
  local keymap = opts.keymap or "<F5>"
 
  vim.api.nvim_set_keymap("n", keymap, 
    [[<cmd>lua require('run_file').run_file()<CR>]],
    { noremap = true, silent = true, desc = "Run current file" })
end

return M
