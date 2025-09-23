--- @brief
---
--- https://github.com/mattn/efm-langserver
---
--- General purpose Language Server that can use specified error message format generated from specified command.
---
--- Requires at minimum EFM version [v0.0.38](https://github.com/mattn/efm-langserver/releases/tag/v0.0.38) to support
--- launching the language server on single files.
---
--- Note: In order for neovim's built-in language server client to send the appropriate `languageId` to EFM, **you must
--- specify `filetypes` in your call to `vim.lsp.config`**. Otherwise the server will be launch on the `BufEnter` instead
--- of the `FileType` autocommand, and the `filetype` variable used to populate the `languageId` will not yet be set.
---
--- ```lua
--- vim.lsp.config('efm', {
---   filetypes = { 'python','cpp','lua' }
---   settings = ..., -- You must populate this according to the EFM readme
--- })
--- ```

local eslint    = require('efmls-configs.linters.eslint_d')
local prettier  = require('efmls-configs.formatters.prettier_d')
local mypy      = require('efmls-configs.linters.mypy')
local cpplint   = require('efmls-configs.linters.cpplint')

local languages = {
  typescript = { eslint, prettier },
  python = { mypy },
  cpp = { cpplint },
}

---@type vim.lsp.Config
return {
  cmd = { "efm-langserver" },
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true
  }
}
