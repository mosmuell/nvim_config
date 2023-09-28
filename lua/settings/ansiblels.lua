return {
  filetypes = {
    "yaml.ansible",
  },
  cmd = { "ansible-language-server", "--stdio" },
  settings = {
    ansible = {
      ansible = {
        path = "ansible",
        useFullyQualifiedCollectionNames = true,
      },
      ansibleLint = {
        enabled = true,
        path = "ansible-lint",
      },
      executionEnvironment = {
        enabled = false,
      },
      python = {
        interpreterPath = "python",
      },
      completion = {
        provideRedirectModules = true,
        provideModuleOptionAliases = true,
      },
    },
  },
  root_dir = require("lspconfig.util").root_pattern("ansible.cfg", ".ansible-lint"),
  single_file_support = true,
}
