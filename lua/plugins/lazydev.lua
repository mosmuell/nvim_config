local M = {
  "folke/lazydev.nvim",
  commit = "491452cf1ca6f029e90ad0d0368848fac717c6d2",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
  dependencies = {
    {
      "Bilal2453/luvit-meta",
      commit = "ce76f6f6cdc9201523a5875a4471dcfe0186eb60",
    }, -- optional `vim.uv` typings
  },
}

return M
