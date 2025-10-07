local local_venv_dir = require("utils.paths").get_venv_or_local_venv_dir()
if local_venv_dir then
  vim.env.PATH = local_venv_dir .. "/bin" .. ":" .. vim.env.PATH
end
