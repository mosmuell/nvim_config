return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
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
