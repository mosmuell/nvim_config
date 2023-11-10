local M = {}
M.venv_python = function()
  local paths = require "utils.paths"
  local venv_path = paths.get_venv_or_local_venv_dir()
  if venv_path then
    return venv_path .. "/bin/python"
  end
  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

--- Derive the full module path based on the file's location
-- @param filepath (string): The full path to the python file
-- @param rootpath (string): The root directory of the project
-- @return (string): The module path in the format package1.subpackage1.module1
M.derive_module_path = function(full_file_path, workspace_folder)
  local module_path = full_file_path:sub(#workspace_folder + 2, -4) -- +2 to remove the trailing slash and the file extension

  -- Convert slashes to dots
  module_path = module_path:gsub("/", ".")

  return module_path
end

local get_launchjs_entries = function()
  -- get the entries of .vscode/launch.json
  require("dap.ext.vscode").load_launchjs(nil, {})
  -- update the pythonPath for each configuration to be the currently selected virtual environment
  --
  for _, config in ipairs(require("dap").configurations.python) do
    config.pythonPath = M.venv_python()
    if config.module == "${fileAsModule}" then
      -- Retrieve the directory in which Neovim was started
      local workspace_folder = vim.fn.getcwd()
      -- Full path to the current file
      local current_file = vim.fn.expand "%:p"

      config.module = M.derive_module_path(current_file, workspace_folder)
    end
  end
end

M.launch_or_continue = function()
  -- if the dap is not running, get the launch.json entries
  if require("dap").status() == "" then
    get_launchjs_entries()
  end
  -- then continue
  require("dap").continue()
end
return M
