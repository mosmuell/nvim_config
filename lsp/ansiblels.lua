return {
  filetypes = {
    "yaml.ansible",
  },
  cmd = { "ansible-language-server", "--stdio" },
  settings = {
    ansible = {
      python = {
        interpreterPath = "python",
      },
      ansible = {
        path = "ansible",
        useFullyQualifiedCollectionNames = true,
      },
      executionEnvironment = {
        enabled = false,
      },
      validation = {
        enabled = true,
        lint = {
          enabled = true,
          path = "ansible-lint",
        },
      },
      ansibleLint = {
        enabled = true,
        path = "ansible-lint",
      },
      completion = {
        provideRedirectModules = true,
        provideModuleOptionAliases = true,
      },
    },
  },
  root_markers = { "ansible.cfg", ".ansible-lint" },
  -- root_dir = require("lspconfig.util").root_pattern("ansible.cfg", ".ansible-lint"),
  single_file_support = true,
}
