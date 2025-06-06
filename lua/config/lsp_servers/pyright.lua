return {
  cmd = { require("utils.paths").get_venv_executable("pyright-langserver") or "pyright-langserver", "--stdio" },
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
      pythonPath = require("utils.paths").venv_python(),
    },
  },
  single_file_support = true,
}
