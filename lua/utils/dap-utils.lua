local M = {}

M.venv_python = function()
  local venv_path = os.getenv "VIRTUAL_ENV"
  if venv_path then
    return venv_path .. "/bin/python"
  end
  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

local get_launchjs_entries = function()
  -- get the entries of .vscode/launch.json
  require("dap.ext.vscode").load_launchjs(nil, {})
  -- update the pythonPath for each configuration to be the currently selected virtual environment
  for _, config in ipairs(require("dap").configurations.python) do
    config.pythonPath = M.venv_python()
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
