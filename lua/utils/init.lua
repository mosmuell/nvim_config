local M = {}

M.servers = {
  "clangd",
  "lua_ls",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "ruff_lsp",
  "bashls",
  "jsonls",
  "yamlls",
  "ansiblels",
}

M.daps = {
  "python",
  "codelldb",
}

M.formatters = {
  "ruff",
  "stylua",
  "black",
}

M.linters = {
  "ruff",
  "flake8",
  "mypy",
}

return M
