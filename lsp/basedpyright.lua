return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
        inlayHints = {
          variableTypes       = true,
          callArgumentNames   = true,
          functionReturnTypes = true,
          genericTypes        = true,
        },
      },
      pythonPath = require("utils.paths").venv_python(),
    },
  },
  single_file_support = true,
}
