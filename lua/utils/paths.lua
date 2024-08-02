local M = {}
M.get_local_venv_dir = function()
  local cwd = vim.fn.getcwd()

  -- Check for ".venv" and "venv" directories
  local venv_paths = { ".venv", "venv" }
  for _, venv_path in ipairs(venv_paths) do
    local full_path = cwd .. "/" .. venv_path

    -- Use io.open to check if the directory exists
    local f = io.open(full_path, "r")
    if f then
      f:close()
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
return M
