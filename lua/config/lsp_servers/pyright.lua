return {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        typeCheckingMode = "on",
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
      pythonPath = require("utils.paths").venv_python(),
    },
  },
  single_file_support = true,
}
