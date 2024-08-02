return {
  init_options = {
    settings = {
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
        preview = true,
      },
      format = {
        preview = true,
      },
    },
  },
}
