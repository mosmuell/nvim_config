return {
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
