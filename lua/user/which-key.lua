local M = {
  "folke/which-key.nvim",
  commit = "0099511294f16b81c696004fa6a403b0ae61f7a0",
  event = "VeryLazy",
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  d = { name = " Debug" },
  f = { name = "󰭎 Telescope" },
  g = { name = "󰊢 Git" },
  l = { name = " LSP" },
}

function M.config()
  require("which-key").setup({})
  require("which-key").register(mappings, opts)
end

return M
