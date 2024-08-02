local M = {
  "williamboman/mason.nvim",
  commit = "0950b15060067f752fde13a779a994f59516ce3d",
  cmd = "Mason",
  event = "BufReadPre",
  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
      commit = "37a336b653f8594df75c827ed589f1c91d91ff6c",
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      commit = "4ba55f9755ebe8297d92c419b90a946123292ae6",
    },
    {
      "jay-babu/mason-null-ls.nvim",
      commit = "de19726de7260c68d94691afb057fa73d3cc53e7",
    },
  },
}


function M.config()
  local settings = {
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
  require("mason-lspconfig").setup({
    ensure_installed = require("plugins.lsp").lsp_servers,
  })
  -- require("mason-nvim-dap").setup({
  --   -- ensure_installed = require("utils").daps,
  --   automatic_installation = true,
  -- })
  -- require("mason-null-ls").setup({
  --   -- ensure_installed = require("utils").daps, -- mason-null-ls gets formatters from the null-ls setup sources (see ./null-ls.lua)
  --   automatic_installation = true,
  -- })
end

return M
