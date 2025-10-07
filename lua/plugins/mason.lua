local M = {
  "williamboman/mason.nvim",
  -- commit = "0950b15060067f752fde13a779a994f59516ce3d",
  cmd = "Mason",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  local settings = {
    PATH = "append",
    ui = {
      border = "none",
      icons = {
        package_installed = "◍",
        package_pending = "◍",
        package_uninstalled = "◍",
      },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  }

  require("mason").setup(settings)
end

return M
