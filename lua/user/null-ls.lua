local M = {
  "nvimtools/none-ls.nvim",
  event = "BufReadPre",
  commit = "b8fd44ee1616e6a9c995ed5f94ad9f1721d303ef",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      commit = "9a0d3bf7b832818c042aaf30f692b081ddd58bd9",
    },
  },
}

local function get_venv_executable(executable)
  local paths = require "utils.paths"
  local venv_path = paths.get_venv_or_local_venv_dir()
  if not venv_path then
    return nil
  end

  local venv_executable_path = venv_path .. "/bin/" .. executable

  if not paths.file_exists(venv_executable_path) then
    return nil
  end

  return venv_executable_path
end

function M.config()
  local null_ls = require "null-ls"
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup {
    debug = false,
    sources = {
      formatting.prettierd.with { extra_filetypes = { "toml" } },
      formatting.black.with {
        command = get_venv_executable "black",
        extra_args = { "--fast" },
      },
      formatting.isort.with { command = get_venv_executable "isort" },
      -- formatting.ruff.with { command = get_venv_executable "ruff" },
      formatting.stylua,
      -- formatting.google_java_format,
      diagnostics.eslint_d,
      diagnostics.ruff.with { command = get_venv_executable "ruff" },
      diagnostics.flake8.with {
        command = get_venv_executable "flake8",
      },
      diagnostics.mypy.with {
        command = get_venv_executable "mypy",
      },
      diagnostics.cpplint,
    },
  }
end

return M
