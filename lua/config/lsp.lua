-- Give every server the completion capabilities nvim-cmp advertises.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

vim.diagnostic.config({
  virtual_text = { current_line = false },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  underline = true,
  severity_sort = true,
  float = { border = "rounded", source = true },
})

-- Every `lsp/<name>.lua` file is a `vim.lsp.Config` for server `<name>`
-- (see `:help lsp-config`). Enable all of them; install the matching tool
-- with `:Mason` before opening a file of that type.
local servers = {}
for _, file in ipairs(vim.fn.globpath(vim.fn.stdpath("config") .. "/lsp", "*.lua", false, true)) do
  table.insert(servers, vim.fn.fnamemodify(file, ":t:r"))
end
vim.lsp.enable(servers)
