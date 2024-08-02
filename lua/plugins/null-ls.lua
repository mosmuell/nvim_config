local M = {
  "nvimtools/none-ls.nvim",
  event = "BufReadPre",
  commit = "cfa65d86e21eeb60544d5e823f6db43941322a53",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
    },
    {
      "nvimtools/none-ls-extras.nvim",
    },
  },
}

function M.config()
  local null_ls = require("null-ls")
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup({
    debug = true,
    sources = {
      require("none-ls.formatting.ruff").with({ command = require("utils.paths").get_venv_executable("ruff") }),
      formatting.stylua,
      diagnostics.ansiblelint,
      diagnostics.mypy.with({
        command = require("utils.paths").get_venv_executable("mypy"),
      }),
      diagnostics.cpplint,
    },
  })
end

return M
