local M = {}

M.servers = {
  "clangd",
  "lua_ls",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
}

M.daps = {
  "python",
  "codelldb",
}

M.formatters = {
  "stylua",
  "black",
}

M.linters = {
  "flake8",
}

return M
