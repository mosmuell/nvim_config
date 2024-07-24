local M = {}

M.servers = {
  "ansiblels",
  "bashls",
  "clangd",
  "cssls",
  "eslint",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  "ruff_lsp",
  "tsserver",
  "yamlls",
}

M.daps = {
  "python",
  "codelldb",
  "go-debug-adapter",
  "firefox",
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
