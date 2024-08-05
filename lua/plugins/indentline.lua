local M = {
  "lukas-reineke/indent-blankline.nvim",
  tag = "v3.7.1",
  event = { "BufReadPre", "BufNewFile" },
}

function M.config()
  require("ibl").setup({
    -- indent = { char = "|" },
    scope = { enabled = true },
    exclude = {
      -- buftypes = { "terminal", "nofile", "quickfix", "prompt" }
      filetypes = {
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
        "''",
        "NvimTree",
      },
    },
  })
end
return M
