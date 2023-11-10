local M = {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  commit = "60b4a7167c79c7d04d1ff48b55f2235bf58158a7",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      commit = "9a0d3bf7b832818c042aaf30f692b081ddd58bd9",
    },
  },
}

local function get_relative_venv_path()
  local venv_path = os.getenv "VIRTUAL_ENV"
  if venv_path == nil then
    return ""
  end

  local cwd = vim.fn.getcwd()

  -- Count the number of "/" in cwd
  local slash_count = 0
  for _ in string.gmatch(cwd, "/") do
    slash_count = slash_count + 1
  end

  -- Create a string with the same number of "../"
  local relative_path = string.rep("../", slash_count)

  -- Append the venv_path to the relative path
  local full_path = relative_path .. venv_path

  return full_path
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
        prefer_local = get_relative_venv_path() .. "/bin",
        extra_args = { "--fast" },
      },
      formatting.isort.with { prefer_local = get_relative_venv_path() .. "/bin" },
      formatting.stylua,
      -- formatting.google_java_format,
      diagnostics.eslint_d,
      diagnostics.flake8.with {
        prefer_local = get_relative_venv_path() .. "/bin",
      },
      diagnostics.cpplint,
    },
  }
end

return M
