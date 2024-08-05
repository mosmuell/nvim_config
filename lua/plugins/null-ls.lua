local M = {
  "nvimtools/none-ls.nvim",
  event = "VeryLazy",
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

M.formatters_and_linters = {
  "ansiblelint",
  "cpplint",
  "mypy",
  "stylua",
  "ruff",
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
      -- configuring binaries: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md#using-local-executables
      -- require("none-ls.formatting.ruff"),
      require("none-ls.formatting.ruff").with({ command = require("utils.paths").get_venv_executable("ruff") }),
      formatting.stylua,
      diagnostics.ansiblelint,
      diagnostics.mypy.with({
        command = require("utils.paths").get_venv_executable("mypy"),
        -- Fixing mypy when opening new file (https://github.com/nvimtools/none-ls.nvim/issues/97)
        args = function(params)
          return {
            "--hide-error-codes",
            "--hide-error-context",
            "--no-color-output",
            "--show-absolute-path",
            "--show-column-numbers",
            "--show-error-codes",
            "--no-error-summary",
            "--no-pretty",
            params.temp_path,
          }
        end,
        on_output = function(line, params)
          line = line:gsub(params.temp_path:gsub("([^%w])", "%%%1"), params.bufname)
          return null_ls.builtins.diagnostics.mypy._opts.on_output(line, params)
        end,
      }),
      require("none-ls.diagnostics.cpplint"),
    },
  })
end

return M
