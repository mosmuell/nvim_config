return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  init_options = {
    settings = {
      configurationPreference = "filesystemFirst",
      lineLength = 88,
      fixAll = true,
      organizeImports = true,
      showSyntaxErrors = true,
      logLevel = "debug",
      codeAction = {
        disableRuleComment = {
          enable = true,
        },
        fixViolation = {
          enable = true,
        },
      },
      lint = {
        enable = true,
        preview = false,
      },
      format = {
        preview = false,
      },
    },
  },
}
