local M = {
  "williamboman/mason.nvim",
  commit = "4546dec8b56bc56bc1d81e717e4a935bc7cd6477",
  cmd = "Mason",
  event = "BufReadPre",
  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
      commit = "93e58e100f37ef4fb0f897deeed20599dae9d128",
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      commit = "6148b51db945b55b3b725da39eaea6441e59dff8",
    },
    {
      "jay-babu/mason-null-ls.nvim",
      commit = "ae0c5fa57468ac65617f1bf821ba0c3a1e251f0c",
    },
    -- {
    --   "rshkarin/mason-nvim-lint",
    --   commit = "637a5b8f1b454753ec70289c4996d88a50808642",
    -- },
  },
}

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

function M.config()
  require("mason").setup(settings)
  require("mason-lspconfig").setup({
    ensure_installed = require("utils").servers,
    automatic_installation = true,
  })
  require("mason-nvim-dap").setup({
    ensure_installed = require("utils").daps,
    automatic_installation = true,
  })
  require("mason-null-ls").setup({
    -- ensure_installed = require("utils").daps, -- mason-null-ls gets formatters from the null-ls setup sources (see ./null-ls.lua)
    automatic_installation = true,
  })
  -- require("mason-nvim-lint").setup {
  --   ensure_installed = require("utils").linters,
  --   automatic_installation = true,
  -- }
end

return M
