return {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "on",
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
      pythonPath = require("dap-utils").venv_python(),
    },
  },
  single_file_support = true,
}
