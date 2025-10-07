local M = {
  "folke/lazydev.nvim",
  commit = "258d2a5",
  cmd = "LazyDev",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "luvit-meta/library", words = { "vim%.uv" } },
      { "nvim-dap-ui" },
    },
  },
  dependencies = {
    {
      "Bilal2453/luvit-meta",
      commit = "1df30b6",
    }, -- optional `vim.uv` typings
  },
}

return M
