local M = {
  "nvimtools/none-ls.nvim",
  event = "BufReadPre",
  commit = "b8fd44ee1616e6a9c995ed5f94ad9f1721d303ef",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      commit = "4f71c0c4a196ceb656c824a70792f3df3ce6bb6d",
    },
  },
}

local function get_venv_executable(executable)
  local paths = require("utils.paths")
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
  local null_ls = require("null-ls")
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup({
    debug = false,
    sources = {
      -- formatting.black.with {
      --   command = get_venv_executable "black",
      --   extra_args = { "--fast", "-l 88" },
      -- },
      -- formatting.isort.with { command = get_venv_executable "isort" },
      formatting.ruff.with({ command = get_venv_executable("ruff") }),
      formatting.stylua,
      -- formatting.google_java_format,
      diagnostics.ruff.with({ command = get_venv_executable("ruff") }),
      -- diagnostics.flake8.with {
      --   command = get_venv_executable "flake8",
      -- },
      diagnostics.mypy.with({
        command = get_venv_executable("mypy"),
      }),
      diagnostics.cpplint,
    },
  })
end

return M
