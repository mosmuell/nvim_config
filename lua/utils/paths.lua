local M = {}

function M.get_local_venv_dir()
  local cwd = vim.fn.getcwd()

  for _, venv_path in ipairs({ ".venv", "venv" }) do
    local full_path = vim.fs.joinpath(cwd, venv_path)
    local stat = vim.uv.fs_stat(full_path)
    if stat and stat.type == "directory" then
      return full_path
    end
  end

  return nil
end

M.get_venv_or_local_venv_dir = function()
  local venv_path = os.getenv("VIRTUAL_ENV") or M.get_local_venv_dir()
  return venv_path
end

---@param name string
---@return boolean
M.file_exists = function(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  end
  return false
end

---Returns the full path of the executable in the activated or local venv folder if it
---exists.
---@param executable string
---@return string | nil
M.get_venv_executable = function(executable)
  local venv_path = M.get_venv_or_local_venv_dir()
  if not venv_path then
    return nil
  end

  local venv_executable_path = venv_path .. "/bin/" .. executable

  if not M.file_exists(venv_executable_path) then
    return nil
  end

  return venv_executable_path
end

M.venv_python = function()
  local venv_path = M.get_venv_or_local_venv_dir()
  if venv_path then
    for _, python_bin in ipairs({ "Scripts/python.exe", "bin/python" }) do
      local candidate = vim.fs.joinpath(venv_path, python_bin)
      if vim.uv.fs_stat(candidate) then
        return candidate
      end
    end
  end
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

return M
